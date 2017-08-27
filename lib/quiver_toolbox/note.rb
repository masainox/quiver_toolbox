
class QuiverToolbox::Note
  EXTENSION = 'qvnote'
  RESOURCES_DIR = 'resources/'
  META_JSON_FILE_NAME = 'meta.json'
  CONTENT_JSON_FILE_NAME = 'content.json'

  KEY_CREATED_AT = 'created_at'
  KEY_TAGS = 'tags'
  KEY_TITLE = 'title'
  KEY_UPDATED_AT = 'updated_at'
  KEY_UUID = 'uuid'
  KEY_CELLS = 'cells'

  JSON_KEYS = [
    KEY_CREATED_AT,
    KEY_TAGS,
    KEY_TITLE,
    KEY_UPDATED_AT,
    KEY_UUID,
    KEY_CELLS
  ]


  def self.open(note_file_path)
    dir = note_file_path
    content_json_file = File.join(dir, 'content.json')
    content_json = JSON.load(File.open(content_json_file).read)

    meta_json_file = File.join(dir, 'meta.json')
    meta_json = JSON.load(File.open(meta_json_file).read)

    notebook_path = nil
    Pathname.new(dir).ascend do |v|
      notebook_path =  v.expand_path.to_s if v.basename.to_s.match('.qvnotebook')
    end

    QuiverToolbox::Note.new do |n|
      n.created_at = meta_json['created_at']
      n.tags = meta_json['tags']
      n.title = meta_json['title']
      n.updated_at = meta_json['updated_at']
      n.uuid = meta_json['uuid']
      n.cells = content_json['cells']
      n.notebook_path = notebook_path
    end
  end


  JSON_KEYS.each {|key| attr_accessor key.to_sym }
  attr_accessor :file, :notebook_path
  attr_reader :resources
  def initialize(attributes = nil)
    attributes.each do |k, v|
      send("#{k.to_s}=", v) if respond_to?("#{k.to_s}=")
    end if attributes
    yield self if block_given?
  end


  def file_name
    "#{uuid}.#{EXTENSION}"
  end


  def notebook_path
    @notebook_path ||= './'
  end


  def file_name_with_path
    File.join(notebook_path, file_name)
  end


  def resources_dir
    File.join(file_name_with_path, RESOURCES_DIR)
  end


  def src_resources=(src_files)
    @resources = []
    src_files.each do |src_file|
      dist_file = File.join(resources_dir, "#{QuiverToolbox::Util.rename_to_uuid_file(src_file)}")
      @resources << {'src' => src_file, 'dist' => dist_file}
    end
  end


  def meta_json_file
    File.join(file_name_with_path, META_JSON_FILE_NAME)
  end


  def meta_json_hash
    {
      KEY_CREATED_AT => @created_at,
      KEY_TAGS => @tags,
      KEY_TITLE => @title,
      KEY_UPDATED_AT => @updated_at,
      KEY_UUID => @uuid
    }
  end


  def meta_json_string
    JSON.pretty_generate(meta_json_hash)
  end


  def content_json_file
    File.join(file_name_with_path, CONTENT_JSON_FILE_NAME)
  end


  def content_json_hash
    {
      KEY_TITLE => @title,
      KEY_CELLS => @cells
    }
  end


  def content_json_string
    JSON.pretty_generate(content_json_hash)
  end


  def store
    store_meta_json
    store_content_json
    store_resources if @resources
    self
  end


  def store_resources
    FileUtils.mkdir_p(resources_dir)
    @resources.each do |hash|
      FileUtils.cp(hash['src'], hash['dist'])
    end
    self
  end


  def store_meta_json(store_file = meta_json_file)
    FileUtils.mkdir_p(file_name_with_path)
    File.open(store_file, 'w') do |f|
      f.puts meta_json_string
    end
    self
  end


  def store_content_json(store_file = content_json_file)
    FileUtils.mkdir_p(file_name_with_path)
    File.open(store_file, 'w') do |f|
      f.puts content_json_string
    end
    self
  end

end

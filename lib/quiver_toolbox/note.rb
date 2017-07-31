
class QuiverToolbox::Note
  EXTENSION = 'qvnote'
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

    QuiverToolbox::Note.new do |n|
      n.created_at = meta_json['created_at']
      n.tags = meta_json['tags']
      n.title = meta_json['title']
      n.updated_at = meta_json['updated_at']
      n.uuid = meta_json['uuid']
      n.cells = content_json['cells']
    end
  end


  JSON_KEYS.each {|key| attr_accessor key.to_sym }
  attr_accessor :file, :notebook_path
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

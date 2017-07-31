
class QuiverToolbox::Notebook
  EXTENSION = 'qvnotebook'
  META_JSON_FILE = 'meta.json'
  JSON_KEY_NAME = 'name'
  JSON_KEY_UUID = 'uuid'


  def self.open(notebook_file)
    meta_json_file = File.join(notebook_file, META_JSON_FILE)
    meta_json = JSON.load(File.open(meta_json_file).read)

    new do |n|
      n.name = meta_json[JSON_KEY_NAME]
      n.uuid = meta_json[JSON_KEY_UUID]
      n.file = notebook_file
    end
  end


  attr_accessor :name, :uuid, :store_path, :file
  def initialize(attributes = nil)
    attributes.each do |k, v|
      instance_variable_set("@#{k}", v)
    end if attributes
    yield self if block_given?
  end


  def uuid
    @uuid ||= QuiverToolbox::Util.generate_uuid
  end


  def store_path
    @store_path ||= './'
  end


  def file
    @file ||= "#{uuid}.#{EXTENSION}"
  end


  def file_with_path
    @file_with_path ||= File.join("#{store_path}", file)
  end


  def meta_json_file
    @meta_json_file ||= File.join(file_with_path, "meta.json")
  end


  def meta_json_hash
    {
      'name' => @name,
      'uuid' => @uuid
    }
  end


  def meta_json_string
    JSON.pretty_generate(meta_json_hash)
  end


  def store
    FileUtils.mkdir_p(file_with_path)
    File.open(meta_json_file, 'w') do |f|
      f.puts meta_json_string
    end
    self
  end


  def build_note(note_hash)
    note = QuiverToolbox::Note.new(note_hash)
    note.notebook_path = file_with_path
    note
  end

end

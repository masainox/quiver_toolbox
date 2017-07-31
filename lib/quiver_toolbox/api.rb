
module QuiverToolbox::API
end


class QuiverToolbox::API::CreateNotebook
  attr_reader :result, :notebook
  def initialize(name, uuid, path)
    @result = nil
    @notebook = QuiverToolbox::Notebook.new do |n|
      n.name = name
      n.uuid = uuid
      n.store_path = path
    end
  end


  def exec
    self
  end


  def store
    @notebook.store
    @result = @notebook.file_with_path
    self
  end
end


class QuiverToolbox::API::CreateNote

  attr_reader :result, :note
  def initialize(title, body, attr)
    @result = nil
    @note = QuiverToolbox::Note.new(attr)
    @note.file = File.join(attr['notebook_path'], @note.file_name)
    @note.title = title
    @note.cells = [
      {
        'type' => attr['type'],
        'data' => body
      }
    ]
  end

  def exec
    self
  end

  def store
    @note.store
    @result = @note.file
    self
  end
end

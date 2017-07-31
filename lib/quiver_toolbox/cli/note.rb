
class QuiverToolbox::CLI::Note < Thor
  class << self
    def exit_on_failure?
      true
    end
  end

  attr_reader :api

  desc "create NOTE_TITLE NOTE_BODY", "Create UUID.qvnote"
  option :uuid, :aliases => :u
  option :type, :default => 'text'#, :aliases => :b
  option :path, :aliases => :p
  option :tags, :aliases => :t, :type => :array

  def create(title, body)
    @api = QuiverToolbox::API::CreateNote.new(title, body, create_options)
    @api.exec.store
    self
  end


private
  def create_options
    now_time = QuiverToolbox::Util.now_unixtime
    new_options = options.dup
    new_options['uuid'] ||= QuiverToolbox::Util.generate_uuid
    new_options['notebook_path'] = new_options['path'] || './'
    new_options['created_at'] ||= now_time
    new_options['updated_at'] ||= now_time
    new_options
  end
end


class QuiverToolbox::CLI::Notebook < Thor
  class << self
    def exit_on_failure?
      true
    end
  end

  attr_reader :api

  desc "create NOTEBOOK_NAME", "Create UUID.qvnotebook"
  option :uuid, :aliases => :u
  option :path, :aliases => :p
  def create(name)
    @api =  QuiverToolbox::API::CreateNotebook.new(name, create_options['uuid'], create_options['path'])
    @api.exec.store
    self
  end

private
  def create_options
    new_options = options.dup
    new_options['uuid'] ||= QuiverToolbox::Util.generate_uuid
    new_options['path'] ||= './'
    new_options
  end
end

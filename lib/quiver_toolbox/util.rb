
require 'securerandom'

module QuiverToolbox::Util
  def self.generate_uuid
    SecureRandom.uuid
  end

  def self.now_unixtime
    Time.now.to_i
  end

  def self.rename_to_uuid_file(src_file)
    src_extname = File.extname(src_file)
    dist_file = "#{generate_uuid.gsub!(/-/,'')}#{src_extname}"
    dist_file
  end
end

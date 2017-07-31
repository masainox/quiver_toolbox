
require 'securerandom'

module QuiverToolbox::Util
  def self.generate_uuid
    SecureRandom.uuid
  end

  def self.now_unixtime
    Time.now.to_i
  end
end

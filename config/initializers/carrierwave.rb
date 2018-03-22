class CarrierWave::Uploader::Base
  #add_config :delete_original_file
end

CarrierWave.configure do |config|
  #config.delete_original_file = true
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end
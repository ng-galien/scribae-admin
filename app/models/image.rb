#=================================================================================
# Image record 
# 
#=================================================================================
class Image < ApplicationRecord
  
    belongs_to :imageable, polymorphic: true
    mount_uploader :upload, ImageUploader

    def is_valid?
      !self.upload.url.nil?
    end
end

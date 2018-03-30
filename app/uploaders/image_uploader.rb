class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  #after :cache, :unlink_original

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #'public/upload/images'
    "upload/images/#{model.imageable_type}/#{model.imageable_id}/#{model.id}"
  end

  # Define the filename output
  def filename 
    "img.#{model.upload.file.extension}" if original_filename 
  end 

  def content_type_whitelist
    /image\//
  end

  #def move_to_cache
  #  true
  #end

  #def move_to_store
  #  true
  #end

  #SIZE XL, For screen display up to
  version :xl, if: :is_responsive? do
    process resize_to_fit: [2500, 2500]
    process :convert => 'jpg'
    process :quality => 40
  end
  #SIZE L, For screen display up to
  version :l, if: :is_responsive? do
    process resize_to_fit: [1900, 1900]
    process :convert => 'jpg'
    process :quality => 50
  end
  #SIZE M, For screen display up to
  version :m do
    process resize_to_fit: [1500, 1500]
    process :convert => 'jpg'
    process :quality => 65
  end
  #SIZE S, For screen display up to
  version :s, if: :is_responsive? do
    process resize_to_fit: [1000, 1000]
    process :convert => 'jpg'
    process :quality => 70
  end
  #SIZE XS, For screen display up to
  version :xs, if: :is_responsive? do
    process :resize_to_fit => [600, 600]
    process :convert => 'jpg'
    process :quality => 90
  end

  protected
  
  def is_responsive? image
    #puts model.inspect
    return model.category == 'bg'
  end

private

  #delete the original file
  def unlink_original (file)
    return unless delete_original_file
    puts "#{version_name}"
    if version_name.blank?
      #puts "delete"
      File.delete 
    end
  end

end

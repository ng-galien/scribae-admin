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
    "uploads/images/#{model.class.to_s.underscore}/#{model.imageable_type}/#{model.imageable_id}/#{model.id}"
  end
  #def filename
  #   "#{version_name}.jpg" if original_filename
  #  "#{model.nicely_formatted_filename}.png"
  #end
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

  #SIZE XL
  version :xl, if: :is_responsive? do
    process resize_to_fit: [2500, 2500]
    process :convert => 'jpg'
    process :quality => 40
  end
  #SIZE L
  version :l, if: :is_responsive? do
    process resize_to_fit: [1900, 1900]
    process :convert => 'jpg'
    process :quality => 50
  end
  #SIZE M
  version :m do
    process resize_to_fit: [1500, 1500]
    process :convert => 'jpg'
    process :quality => 65
  end
  #SIZE S
  version :s do
    process resize_to_fit: [1000, 1000]
    process :convert => 'jpg'
    process :quality => 70
  end
  #SIZE XS
  version :xs do
    process :resize_to_fit => [600, 600]
    process :convert => 'jpg'
    process :quality => 90
  end

  protected
  
  def is_responsive? image
    puts model.inspect
    #puts model.class
    #puts model.id
    #puts model.category
    #puts model.imageable_type
    #model.category == 'article_main'
    model.category == 'bg'
    #true
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

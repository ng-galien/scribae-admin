class ImageUploader0 < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick



  after :cache, :unlink_original



  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #'public/upload/images'
    "uploads/#{model.class.to_s.underscore}/#{model.imageable_type}/#{model.imageable_id}/#{model.id}"
  end
  #def filename
  #   "#{version_name}.jpg" if original_filename
  #  "#{model.nicely_formatted_filename}.png"
  #end
  def filename 
    "original.#{model.upload.file.extension}" if original_filename 
  end 
end 

  def content_type_whitelist
    /image\//
  end

  def move_to_cache
    true
  end

  def move_to_store
    true
  end

  version :regular, :if => :is_regular? do
    process resize_to_fit: [900, 900]
    process :quality => 90
  end
  version :thumb, :if => :is_regular? do
    process resize_to_fit: [200, 200]
    process :quality => 100
  end

  version :xl, :if => :is_responsive? do
    process resize_to_fit: [1600, 1600]
    process :quality => 85
  end
  version :l, :if => :is_responsive? do
    process resize_to_fit: [1200, 1200]
    process :quality => 90
  end
  version :m, :if => :is_responsive? do
    process resize_to_fit: [1000, 1000]
    process :quality => 90
  end
  version :s, :if => :is_responsive? do
    process resize_to_fit: [800, 800]
    process :quality => 95
  end
  version :xs, :if => :is_responsive? do
    process resize_to_fit: [600, 600]
    process :quality => 100
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  #

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
     %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.


private

  def is_responsive? picture
    puts "is_responsive? #{model.imageable_type == 'Website'}"
    model.imageable_type == 'Website'
  end

  def is_regular? picture
    puts "is_regular? #{model.imageable_type != 'Website'}"
    model.imageable_type != 'Website'
  end


  #delete the original file
  def unlink_original (file)
    return unless delete_original_file
    puts "#{version_name}"
    if version_name.blank?
      puts "delete"
      File.delete 
    end
  end

end

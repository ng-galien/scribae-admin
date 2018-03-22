class GpxUploader < CarrierWave::Uploader::Base
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #'public/upload/images'
    "uploads/gpx/#{model.id}"
  end
  #def filename
  #   "#{version_name}.jpg" if original_filename
  #  "#{model.nicely_formatted_filename}.png"
  #end
  def filename 
    "trace.#{model.upload.file.extension}" if original_filename 
  end

end
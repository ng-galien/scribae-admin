# Job for image copy to preview folder
# Used when an image is updated from image controller
class ImageJob < ApplicationJob
  queue_as :default
  include PreviewsHelper

  def perform(*args)
    # control if we have an image in args
    begin
      args.length == 1 or !args[0].nil? or raise ArgumentError 'Argument is invalid'
      image = args[0]
      model_obj = image.imageable_type
      .classify
      .constantize
      .find(image.imageable_id)
      website = nil
      all = false
      
      if image.imageable_type == "Website"
        website = model_obj
        all = true
      else
        website = Website.find model_obj.website_id
      end
      preview = Preview.where(website_id: website.id).first
      dest = get_dest_path preview
      copy_image image, dest, true, all
    rescue exception => exception
      pp exception.backtrace
    end
  end
end
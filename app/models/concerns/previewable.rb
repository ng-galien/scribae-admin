#=================================================================================
# Concern for preview
# Inject method for Front matter
#=================================================================================
module Previewable
  extend ActiveSupport::Concern

    included do
      #=================================================================================
      # CLASS METHODS
      #=================================================================================
      # Return the supplementary query criteria
      def self.get_query_criteria
        if is_component?
          {  }
        elsif is_article?
          { fake: false }
        else
          {} 
        end
      end

      #===============================================================================
      # Return the preview dir
      def self.to_preview_dir
        if is_component?
          ""
        elsif is_article?
          "_posts"
        else
          "_" + "#{self}".pluralize.downcase
        end
      end

      #===============================================================================
      # If the class is article
      def self.is_component?
        !!("#{self}" == "Component")
      end
      #===============================================================================
      # If the class is article
      def self.is_article?
        !!("#{self}" == "Article")
      end

      #===============================================================================
      # If the class is album
      def self.is_album?
        return !!("#{self}" == "Album")
      end
    
    end

    #=================================================================================
    # INSTANCE METHODS
    #=================================================================================
    # Get the front matter filename the a previewable
    def to_filename
      # Component specific
      if self.class.is_component?
        if self.name == "articles"
          "posts/index.html"
        else
          "#{name}.md"
        end
      elsif self.has_attribute? :date
        "#{self.date.year}-#{self.date.month}-#{self.date.mday}-#{self.title.parameterize}-#{self.id}.md" 
      else
        "#{self.title.parameterize}-#{self.id}.md"
      end
    end

    #=================================================================================
    # Get the relative url for the previewable
    def to_url
      "#{self.class.to_preview_dir}/#{to_filename}"
    end

    #=================================================================================
    # Return the front matter and the images list for a previewable
    # 
    # Params:
    def get_content
      # Image section
      is_comp = self.class.is_component?
      copy_album = false
      images = []
      image_main = nil
      # Album?
      if self.class.is_album?
        copy_album = !self.extern
      end
      # Fill array with used images
      unless is_comp
        imgs = self.images.order(pos: :desc)
        imgs.each do |img|
          if img.is_valid?
            if img.category == 'main'
              image_main == img.upload.m.url
            elsif /#{img.upload.url}/ =~ self.markdown
              images << img
            elsif copy_album
              images << img
            end
          end
        end
      end

      # Front matter section 
      # fill head
      front_matter = [
        "---",
        "#--------------",
        "# #{self.class.name} model",
        "#--------------",
        "# Creation date",
        "created: #{self.created_at.to_f}",
        "# Last update",
        "updated: #{self.updated_at.to_f}",
        "# Layout"
      ]
      # Component specific
      if is_comp
        front_matter << "layout: #{self.name}"
        if self.name != "articles"
          front_matter << "permalink: /#{self.name}/"
        end
      else
        front_matter << "layout: #{self.class.name.downcase}"
      end
      
      # fill attributes 
      attrs = self.attributes
      attrs.each do |key, value|
        # Component specific
        if is_comp
          if !['id', 'website_id', 'created_at', 'updated_at', 'markdown', 'name'].include?(key)
            if key == "icon_color"
              front_matter << "#{key}: #{value.sub!( /^#/, '' )}"
            else
              front_matter << "#{key}: #{value}"
            end
          end
        else
          if !['id', 'website_id', 'created_at', 'updated_at', 'markdown'].include?(key)
            #component specific
            if value.is_a? String
              front_matter << "#{key}: |"
              lines = value.split(/\n+/)
              lines.each do |line|
                front_matter << "  #{line}"
              end
            elsif value.is_a? Date
              front_matter << "#{key}: #{I18n.l(value)}"
            else
              front_matter << "#{key}: #{value}"
            end
          end
        end
      end
      # images if it's not a component
      unless is_comp
        # fill main image
        front_matter << "image: #{image_main}"
        # copy album
        if copy_album
          front_matter << "album:"
          images.each do |img|
            front_matter << "  -#{img.upload.m.url}"
          end
        end
      end
      # markdown
      front_matter << "---"
      if self.has_attribute? :markdown
        front_matter << self.markdown
      end
      # return the array with frontmatter and array of images
      [front_matter.join("\n"), images]
    end  

end
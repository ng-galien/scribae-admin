require 'open3'
require 'i18n'
#=================================================================================
# Helper for generating the website preview and running
# Jekyll. 
#=================================================================================
module PreviewHelper

  include TerminalHelper
  include ProcessHelper

  #=================================================================================
  # Get the destination path of the preview
  # 
  # Params:
  # +preview+:: the site preview
  def get_dest_path website
    conf = Rails.configuration.scribae['preview']
    return Rails.root.join(
      conf['target'], 
      website.name.parameterize)
  end

  #=================================================================================
  # Update site data
  # Create data file of the website configuration
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def update_data website
    dest = get_dest_path website.preview
    data_dir = File.join(dest, "_data")
    FileUtils.mkdir_p(data_dir)
    data_file = File.join(data_dir, "scribae.json")
    comps = Component.all
    data = {
      "components" => comps
    }
    File.open(data_file,'w') do |f| 
      f.write data.to_json
    end
  end

  #=================================================================================
  # Create config
  # 
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def create_config website, local=true
    dest = get_dest_path website.preview
    baseurl = local ? "/scribae" :  "/#{website.gitconfig.base_url}"
    config = {
      "title" => "#{website.site_title}",
      "lang" => "",
      "email" => "",
      "description" => "#{website.description}",
      "repository" => "#{website.gitconfig.repo_link}",
      "baseurl" => baseurl,
      "url" => "",
      "markdown" => "kramdown",
      "sass" => {
        "style" => "compresses"
      },
      'exclude' => "_infos",
      "collections" => {
        "albums" => {
          "output" => true,
          "permalink" => "/:collection/:name"
        },
        "themes" => {
          "output" => true,
          "permalink" => "/:collection/:name"
        },
        "infos" => {
          "output" => false
        }
      },
      "permalink" => "/posts/:year-:month-:day-:title",
      "paginate" => 10,
      "paginate_path" => "/posts/page-:num/",
      "local" => local
      #"profile" => true,
      #"incremental" => true
    }
    dest_file = local ? "_config_local.yml" : "_config.yml"
    File.open(File.join(dest, dest_file),'w') do |f| 
      f.write config.to_yaml
    end
  end

  
  #=================================================================================
  # Create home page
  # 
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def update_home website, trigger=false
    preview = website.preview
    dest = get_dest_path preview
    terminal_add preview, terminal_info(I18n.t('preview.message.job.home'))
    path = Rails.root.join(dest, "index.md")

    if is_new path, website
      top_image = Image.where({
        imageable_type: 'Website',
        imageable_id: website.id,
        name: 'top'
      }).first
      copy_image top_image, dest, true, true
      bottom_image = Image.where({
        imageable_type: 'Website',
        imageable_id: website.id,
        name: 'bottom'
      }).first
      copy_image bottom_image, dest, true, true
      puts "============== WRITE => #{path}"
      File.open(path, "w") do |file| 
        head = [
          "---",
          "#--------------",
          "# Modèle page d'accueil",
          "#--------------",
          "# Creation date",
          "created: #{website.created_at.to_f}",
          "# Last update",
          "updated: #{website.updated_at.to_f}",
          "# Ne pas modifier cette section pour les débutants!",
          "layout: home",
          "permalink: /",
          "# Ordre de la page, au minimum pour la page d'accueil",
          "pos: 0",
          "# Affiche le lien dans le menu",
          "show: true",
          "#--------------",
          "# Section à personnaliser",
          "# Titre pour le menu et la navigation",
          "title: #{website.home_title}",
          "# Icone de la page",
          "icon: #{website.home_icon}",
          "# Titre principal sur la première image",
          "top-title: #{website.top_title}",
          "# Texte en sous titre",
          "top-intro: #{website.top_intro}",
          "# Top image",
          "top-image: #{File.dirname(top_image.upload.url)}",
          "# Titre principal sur la deuxième image",
          "bottom-title: #{website.bottom_title}",
          "# Texte en sous titre",
          "bottom-intro: #{website.bottom_intro}",
          "# Bottom image",
          "bottom-image: #{File.dirname(bottom_image.upload.url)}",
          "# Titre pour les articles mis en avant",
          "featured-title: #{website.featured_title}",
          "# Afficher ou non le contenu markdown",
          "show-content: #{website.show_markdown}",
          "---",
          "#{website.markdown}"

        ]
        file << head.join("\n")
      end
      if trigger
        terminal_add preview, terminal_trigger(
          I18n.t('preview.trigger.page'), "/")
      end     
    end
  end

  #=================================================================================
  # Create content
  # 
  # Params:
  # +website+:: the website
  # +domain+:: Class name from controller ex: Article, Theme, ..., Component
  # +trigger+:: Trig the terminal if a previewable object is updated
  def update_domain( website, domain, trigger=false )

    has_updated = false
    preview = website.preview
    # Log info
    terminal_add( preview, terminal_info(I18n.t("preview.message.job.#{domain.downcase}")) )
    dest = get_dest_path website
    # The domain dir is domain pluralized and downcase "Theme" => "themes" 
    classified = domain.classify.constantize

    preview_dir = classified.to_preview_dir
    # The query criteria
    criteria = {website_id: website.id}.merge (classified.get_query_criteria)
    # get the list 
    list = classified.where(criteria)
    # Clean the obj target directory
    check_target_dir Rails.root.join(dest, preview_dir), list
    # Clean the domain images
    obj_ids = list.map { |obj| obj.id }
    clean_domain_images( dest, domain.singularize, obj_ids )
    # Object loop
    list.each do |obj|  
      # Copy front matter file
      obj_path = Rails.root.join dest, preview_dir, obj.to_filename
      if is_new( obj_path, obj )        
        # Create the obj dir if it does not exists
        FileUtils.mkdir_p File.dirname(obj_path)
        # Write the file
        content = obj.get_content
        File.open(obj_path, "w") do |file|
          file << content[0]
        end
        # Copy images
        images = content[1]
        images.each do |image|
          copy_image image, dest
        end
        # Clean unused image
        images_target_dir = File.join(dest, "upload/images/#{obj.class.name}/#{obj.id}")
        clean_obj_images images_target_dir, images.map { |img| img.id}
        # Trig the url to terminal if updated
        if trigger
          terminal_add preview, terminal_trigger(
            I18n.t('preview.trigger.page'), obj.to_url)
        end
        has_updated = true
      end  
    end
    has_updated
  end

  #=================================================================================
  # Update the scss style file
  # 
  # Params:
  # +website+:: the website
  def update_style( website, trigger=false )
    
    style = website.style
    preview = website.preview
    terminal_add( preview, terminal_info(I18n.t("preview.message.job.style")) )
    dest = get_dest_path preview
    style_path = File.join(dest, 'css', 'style.scss')
    File.open(style_path, "w") do |file|
      file << "---\n"
      file << "# Only the main Sass file needs front matter\n"
      file << "---\n"
      file << "@charset 'utf-8';"
      file << style.to_scss
      file << "@import 'materialize';"
      file << "@import 'general';"
      file << "@import 'menu';"
      file << "@import 'home';"
      file << "@import 'articles';"
      file << "@import 'themes';"
      file << "@import 'infos';"
      file << "@import 'albums';"
      file << "@import 'maps';"
      file << ""
    end
    if trigger
      terminal_add preview, terminal_trigger(
        I18n.t('preview.trigger.page'), "/")
    end
  end
  
  #=================================================================================
  # Check in the target directory if one file lives without an existing oject
  # The image version is always medium. See image_uploader.rb
  # Params:
  # +dest+:: the target directory
  # +objects+:: list of objects
  # +to_name+:: path translator for the object
  def check_target_dir dest, obj_list
    obj_files = obj_list.map {|obj| obj.to_filename} 
    path = File.join dest, '*.md'
    Dir.glob(path).each do |file|
      if !obj_files.index File.basename(file)
        FileUtils.rm(file)
      end
    end
  end

  #=================================================================================
  # Copy an image object to the preview folder
  # The image version is medium by default. 
  # See image_uploader.rb
  # Params:
  # +image+:: the image model
  # +dest+:: the preview path
  # +all+:: copy all version
  def copy_image image, dest, ctrl= false, all=false

    if image && image.upload.url 
      img_url = image.upload.url
      dest_path = File.join(dest, img_url)
      dest_dir = File.dirname(dest_path)
      dest_info = File.join(dest_dir, "#{image.updated_at.to_f}")
      if ctrl && File.exists?(dest_info)
        return nil
      end
      if ctrl
        FileUtils.rm_rf dest_dir
      end
      urls = [image.upload.m.url]
      if all
        urls = [
          image.upload.xl.url,
          image.upload.l.url,
          image.upload.m.url,
          image.upload.s.url,
          image.upload.xs.url
        ]
      end
      urls.each do |url|
        url.sub!( /^\//, '' )
        src_path = Rails.root.join("public", url)
        dest_path = File.join(dest, url)
        FileUtils.mkdir_p(File.dirname(dest_path))
        FileUtils.cp src_path, dest_path
      end
      if ctrl
        info_file = File.new(dest_info, "w")
        info_file.close
      end
      return File.dirname(image.upload.url)
    else
      return nil
    end
  end

  #=================================================================================
  # Clean all images in the preview dir for deleted object of a specific domain
  # Params:
  # +dest+:: target dir to check
  # +dest+:: the domain
  # +obj_ids+:: array of previewable object id (string) to keep
  def clean_domain_images dest, domain, obj_ids
    if Dir.exists? "#{dest}/upload/images/#{domain}"
      Dir.glob("#{dest}/upload/images/#{domain}/*/").each do |dir|
        basename = Pathname.new(dir).basename.to_s
        unless obj_ids.include? basename
          FileUtils.rm_rf dir
        end
      end
    end
  end
  #=================================================================================
  # Clean all images of a previewable object if it's not used
  # Params:
  # +path+:: target dir to check
  # +image_ids+:: array of images id (string) to keep
  def clean_obj_images path, image_ids
    if Dir.exists? "#{path}"
      Dir.glob("#{path}/*/").each do |dir|
        basename = Pathname.new(dir).basename.to_s
        unless image_ids.include? basename
          FileUtils.rm_rf dir
        end
      end
    end
  end


  #========================================================
  # DEPRECIATED
  # Copy the static content
  # Copy the directory structure of static content of the model
  # Params:
  # +target+:: the target directory
  # +erase+:: erase
  def copy_static_content website, erase=false
    
    proto_dir = 'prototypes'
    preview = website.preview
    target = get_dest_path preview
    proto_name = preview.prototype
    paths = [
      #path.join('assets'),
      #path.join('css'),
      target.join('_posts'),
      target.join('_themes'),
      target.join('_infos'),
      target.join('_albums')
    ]
    FileUtils.mkdir_p(paths)
    ['_sass', '_layouts', '_includes', 'assets', 'css', 'fonts'].each do |dir|
      dest = File.join(target, dir)
      FileUtils.cp_r(
        Rails.root.join(proto_dir, proto_name, dir), 
        dest, :remove_destination => erase, :verbose => true)
    end
    ['Gemfile', 'Gemfile.lock', '.gitignore'].each do |file|
      src = Rails.root.join(proto_dir, proto_name, file)
      dest = Rails.root.join(target, file)
      if File.exist? src
        FileUtils.cp_r src, dest
      end
    end
  end
  
  #========================================================
  # Params:
  # +website
  def update_prototype website
    conf = Rails.configuration.scribae['preview']
    preview = website.preview
    Dir.chdir Rails.root.join(conf['prototypes_dir'])
    cmds = [["./copy_model.sh #{preview.prototype} #{preview.name}", nil, true]] 
    run_commands cmds, preview
  end

  #========================================================
  # Check directory structure
  # Params:
  # +file+::
  # +created+::
  # +updated+::
  def is_new file, obj 
    if file.exist?
      yaml = YAML.load_file(file)
      if yaml
        return (yaml['created'] != obj.created_at.to_f) || (yaml['updated'] != obj.updated_at.to_f)
      end
    end
    true
  end

  #=================================================================================
  # DEPRECIATED
  #=================================================================================
  # Copy all uploaded images int the markdown text content to the preview folder.
  # The image version is always medium. See image_uploader.rb
  # It uses regex of the image markdown pathern,
  # The pathen should have a json desciptor like in the first bracket as:
  # {s:val,a:"val",o:"val"} where: 
  # - s: size in percent as integer
  # - a: align method l|c|r as left, center, right
  # - o: string for further options 
  # Return an array of images id in the markdown 
  # Params:
  # +markdown+:: the mardown text
  # +dest+:: the preview path
  def copy_content_image markdown, dest
    if markdown.nil?
      return []
    end
    url_regex = /upload\/images\/[a-zA-Z]+\/(\d+)\/(\d+)+\/m_img.jpg/
    img_regex = /!\[{s:(\d+),a:"(c|l|r)",o:"(.*)"}\]\(\/(.*)\)/
    images = markdown.scan img_regex
    id_array = []
    images.each do |scan| 
      if scan.length == 4
        url = scan[3]
        url_match = url.scan url_regex
        if url_match.length == 1 && url_match[0].length == 2
          id_array.push "#{url_match[0][1]}"
          src_path = Rails.root.join("public", url)
          dest_path = File.join(dest, url)
          unless File.exists? dest_path
            FileUtils.mkdir_p(File.dirname(dest_path))
            FileUtils.cp src_path, dest_path
          end
        end
      end
    end
    return id_array
  end

end

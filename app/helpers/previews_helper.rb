require 'open3'
require 'i18n'
#=================================================================================
# Helper for generating the website preview and running
# Jekyll. 
#=================================================================================
module PreviewsHelper

  include TerminalHelper

  PREVIEW_STOP = 0;
  PREVIEW_STARTING = 10;
  PREVIEW_STARTED = 20;

  def jekyll_thread preview
    terminal_log preview, terminal_info(I18n.t('preview.message.start'))
    Rails.application.executor.wrap do
      Thread.new do
        Rails.application.reloader.wrap do
          Rails.application.executor.wrap do
            start_jekyll preview
          end
        end
      end
    end
  end
  #=================================================================================
  # Start the process
  # 
  # Params:
  # +pid+:: pid of the process
  def start_jekyll preview
    path = get_dest_path preview
    Dir.chdir path
    Bundler.with_clean_env do
      ActiveSupport::Dependencies.interlock.permit_concurrent_loads do
        begin
          continue = true
          # Test if bundle was previously updated
          out, status = Open3.capture2e("bundle check")
          continue = status.success?
          unless continue
            raise "Bundle check failed"
          end
          bundle_updated = /The Gemfile's dependencies are satisfied/ =~ out
          # Update the bundle
          if bundle_updated.nil?
            Open3.popen2e("bundle update") do |i, oe, t|
              terminal_log preview, terminal_info(I18n.t('preview.message.bundle.start'))
              #preview.status = PREVIEW_STARTING
              #preview.pid = t.pid # pid of the started process.
              #preview.save!
              #terminal_log preview, terminal_trigger("#{t.pid}")
              oe.each {|line|
                #puts line
                terminal_log preview, terminal_cmd(line)
                #error = /warning/ =~ line
              }
              continue = t.value.success?
              if continue
                terminal_log preview, terminal_info(I18n.t('preview.message.bundle.end'))
              else
                terminal_log preview, terminal_info(I18n.t('preview.message.bundle.error'))
              end
            end
            unless continue
              return
            end
          end
          Open3.popen2e("bundle exec jekyll serve") do |i, oe, t|
            terminal_log preview, terminal_info(I18n.t('preview.message.jekyll.start'))
            #preview.pid = t.pid # pid of the started process.
            #preview.save!
            preview.set_starting t.pid

            #terminal_log preview, terminal_trigger(I18n.t('preview.trigger.pid'), "#{preview.pid}")
            oe.each {|line|
              #puts line
              #error = /warning/ =~ line
              terminal_log preview, terminal_cmd(line)

              if /Server address: / =~ line
                address = line.scan /Server address: (.*)/
                preview.url = address[0][0]
                preview.set_started
                terminal_log preview, terminal_trigger(I18n.t('preview.trigger.status'), true)
                terminal_log preview, terminal_info(I18n.t('preview.message.jekyll.started'))
                
              end
              if /...done in ([0-9]*[.])?[0-9]+ seconds./ =~ line
                duration = line.scan /...done in ([0-9]*[.])?[0-9]+ seconds./
                terminal_log preview, terminal_trigger(
                  I18n.t('preview.trigger.update'), "#{duration[0][0]}")
              end
            }
          rescue Exception => error
            #puts error.backtrace
            preview.set_stopped
            terminal_log preview, terminal_trigger(I18n.t('preview.trigger.error'), error.backtrace)
            terminal_log preview, terminal_info(I18n.t('preview.message.jekyll.error'))
          end
        end
        preview.set_stopped
        terminal_log preview, terminal_trigger(I18n.t('preview.trigger.status'), false)
        terminal_log preview, terminal_info(I18n.t('preview.message.jekyll.end'))
      end
    end
  end

  #=================================================================================
  # Get the destination path of the preview
  # 
  # Params:
  # +preview+:: the site preview
  def get_dest_path preview
    conf = Rails.configuration.scribae['preview']
    return Rails.root.join(
      conf['target'], 
      preview.name)
  end

  #=================================================================================
  # Create config
  # 
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def create_config website, dest

    config = {
      "title" => "#{website.name}",
      "lang" => "",
      "email" => "",
      "description" => "#{website.description}",
      "repository" => '',
      "baseurl" => "",
      "url" => "",
      "markdown" => "kramdown",
      "sass" => {
        "style" => "compresses"
      },
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
          "output" => true,
          "permalink" => "/:collection/:name"
        }
      },
      "permalink" => "/posts/:year-:month-:day-:title",
      "paginate" => 10,
      "paginate_path" => "/posts/page-:num/",
      "profile" => true,
      "incremental" => true
    }
    File.open(File.join(dest, '_config.yml'),'w') do |f| 
      f.write config.to_yaml
    end
  end

  #=================================================================================
  # Create components pages
  # 
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def create_comps website, dest
    updated = false
    comps = website.components
    comps.each do |comp|
      if(comp.name == 'articles')
        FileUtils.mkdir_p(File.join(dest, "posts"))
        path = Rails.root.join(dest, "posts", "index.html")
      else
        path = Rails.root.join(dest, "#{comp.name}.md")
      end
      if is_new path, website.created_at, website.updated_at
        file = File.open(path, "w")
        head = [
          "---",
          "#--------------",
          "# Component model",
          "#--------------",
          "# Creation date",
          "created: #{comp.created_at.to_f}",
          "# Last update",
          "updated: #{comp.updated_at.to_f}",
          "# Ne pas modifier cette section pour les débutants!",
          "layout: #{comp.name}",
          "permalink: /#{comp.name}/",
          "# Ordre de la page, au minimum pour la page d'accueil",
          "index: #{comp.pos}",
          "# Affiche le lien dans le menu",
          "nav-link: #{comp.show}",
          "# Affiche le lien sous forme d'icone dans la page d'accueil",
          "home-link: #{comp.show}",
          "#--------------",
          "# Section à personnaliser",
          "# Titre pour le menu et la navigation",
          "nav-title: #{comp.title}",
          "# Titre de la page",
          "title: #{comp.title}",
          "# Icone de la page",
          "icon: #{comp.icon}",
          "# Icone de la page",
          "icon-color: #{ comp.icon_color.sub!( /^#/, '' ) }",
          "# Si home-link est vrai (true) sous-titre ",
          "# de la rubrique affichée dans la page d'accueil",
          "intro: #{comp.intro}",
          "# Afficher ou non le contenu markdown",
          "show-content: #{comp.show_markdown}",
          "---",
        ].join("\n") + "\n"
        file << head
        if(comp.show_markdown)
          file << "#{comp.markdown}\n"
        end
      end
      updated = true
    ensure
      if file
        file.close
      end
      
    end
    return updated
  end
  
  #=================================================================================
  # Create home page
  # 
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def create_home website, dest, update=false
    path = Rails.root.join(dest, "index.md")
    if update or is_new path, website.created_at, website.updated_at
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
      file = File.open(path, "w")
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
        "index: 0",
        "# Affiche le lien dans le menu",
        "nav-link: true",
        "# Affiche le lien sous forme d'icone dans la page d'accueil",
        "home-link: false",
        "#--------------",
        "# Section à personnaliser",
        "# Titre pour le menu et la navigation",
        "nav-title: Accueil",
        "# Theme spécifique (couleur en fonction de l'ordre de la page)",
        "theme: 0",
        "# Titre de la page",
        "page-title: #{website.home_title}",
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
        "---"
      ].join("\n") + "\n"
      file << head
      if(website.show_markdown)
        file << "#{website.markdown}\n"
      end     
    end
  ensure
    if file
      file.close
    end
  end

  #=================================================================================
  # Create content
  # 
  # Params:
  # +list+:: the content obj
  # +dest+::
  # +dir+::
  # +content+::
  def create_content( list, dest, dir, obj_to_filename, obj_to_content, copy_album=false )
    # Clean the target directory
    check_target_dir Rails.root.join(dest, dir), list, &obj_to_filename
    list.each do |obj|
      # The object destination path
      obj_path = Rails.root.join dest, dir, obj_to_filename[obj]
      image_ids = []

      # Control the main image
      img_main = Image.where({
        imageable_type: obj.class.name,
        imageable_id: obj.id,
        category: 'main'
      }).first
      unless img_main.nil?
        # Copy the main image
        copy_image img_main, dest
        image_ids.push "#{img_main.id}"
      end
      # Write if file doesn't exists or timestamp difference
      exists = File.exist? obj_path
      is_new = is_new( obj_path, obj.created_at, obj.updated_at )
      if !exists or is_new
        # Image arr, first is main, second is album
        img_arr = [nil, nil]
        if img_main.upload.url
          img_arr[0] = "#{File.dirname(img_main.upload.url)}/m_img.jpeg"
        end
        # Copy the image list and add to it image array
        if copy_album
          images = obj.images.order(pos: :desc)
          album_arr = []
          images.each do |image|
            img_item = copy_image image, dest, false, false
            image_ids.push "#{image.id}"
            unless img_item.nil?
              album_arr.push "#{img_item}/m_img.jpeg"
            end
          end
          img_arr[1] = album_arr
        end
        content = obj_to_content[obj, img_arr]
        file = File.open(obj_path, "w")
        file << content.join("\n")
        # Copy markdown if exists
        if obj.attributes.has_key? 'markdown'
          image_ids.concat copy_content_image( obj.markdown, dest )
          file << "#{obj.markdown}\n"
        end
        file.close
      end
      images_target_dir = File.join(dest, "upload/images/#{obj.class.name}/#{obj.id}")
      clean_images images_target_dir, image_ids
    end
  end
  
  #=================================================================================
  # Create articles pages
  # 
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def create_articles website, dest
    obj_to_filename = lambda { |obj|
      "#{obj.date.year}-#{obj.date.month}-#{obj.date.mday}-#{obj.title.parameterize}-#{obj.id}.md" 
    }
    obj_to_content = lambda { |obj, img_arr|
      [
        "---",
        "#--------------",
        "# Article model",
        "#--------------",
        "# Fixed section do not modify",
        "# Creation date",
        "created: #{obj.created_at.to_f}",
        "# Last update",
        "updated: #{obj.updated_at.to_f}",
        "# Layout",
        "layout: post",
        "#--------------",
        "# Custom section",
        "# Publication date",
        "date: #{I18n.localize obj.date}",
        "# Title",
        "title: #{obj.title}",
        "# Introduction text",
        "intro: #{obj.intro}",
        "# Main image",
        "main-img: #{img_arr[0]}",
        "# If the article is show on home page",
        "featured: #{obj.featured}",
        "# Categories",
        "categories: ",
        "---",
        "",
      ]
    }
    articles = website.articles.select { |article| !article.fake }
    create_content articles, dest, "_posts", obj_to_filename, obj_to_content
  end

  #=================================================================================
  # Create themes pages
  # 
  # Params:
  # +website+:: the website
  # +dest+:: the destination path
  def create_themes website, dest
    obj_to_filename = lambda { |obj|
      "#{obj.title.parameterize}-#{obj.id}.md" 
    }
    obj_to_content = lambda { |obj, img_arr|
      [
        "---",
        "#--------------",
        "# Theme model",
        "#--------------",
        "# Fixed section do not modify",
        "# Creation date",
        "created: #{obj.created_at.to_f}",
        "# Last update",
        "updated: #{obj.updated_at.to_f}",
        "# Layout",
        "layout: theme",
        "#--------------",
        "# Custom section",
        "# Index",
        "pos: #{obj.pos}",
        "# Title",
        "title: #{obj.title}",
        "# Introduction text",
        "intro: #{obj.intro}",
        "# Main image",
        "main-img: #{img_arr[0]}",
        "# Categories",
        "categories: ",
        "---",
        "",
      ]
    }
    themes = website.themes
    create_content themes, dest, "_themes", obj_to_filename, obj_to_content
  end

  #=================================================================================
  # Create info pages
  # 
  # Params:
  # +website+:: the website
  # +dest+:: the destination path
  def create_infos website, dest
    obj_to_filename = lambda { |obj|
      "#{obj.title.parameterize}-#{obj.id}.md" 
    }
    obj_to_content = lambda { |obj, img_arr|
      [
        "---",
        "#--------------",
        "# Information section model",
        "#--------------",
        "# Fixed section do not modify",
        "# Creation date",
        "created: #{obj.created_at.to_f}",
        "# Last update",
        "updated: #{obj.updated_at.to_f}",
        "#--------------",
        "# Custom section",
        "# Index",
        "pos: #{obj.pos}",
        "# Title",
        "title: #{obj.title}",
        "---",
        "",
      ]
    }
    infos = website.infos
    create_content infos, dest, "_infos", obj_to_filename, obj_to_content
  end

  #=================================================================================
  # Create album pages
  # 
  # Params:
  # +website+:: the website
  # +dest+:: the destination path
  def create_albums website, dest
    obj_to_filename = lambda { |obj|
      "#{obj.title.parameterize}-#{obj.id}.md" 
    }
    obj_to_content = lambda { |obj, img_arr|
      img_section = [
        "# Image collection",
        "images:"
      ]
      unless img_arr[1].nil?
        img_arr[1].each do |img|
          img_section.push "  - #{img}"
        end
      end
      img_section.push "---"
      img_section.push ""
      [
        "---",
        "#--------------",
        "# Information section model",
        "#--------------",
        "# Fixed section do not modify",
        "# Creation date",
        "created: #{obj.created_at.to_f}",
        "# Last update",
        "updated: #{obj.updated_at.to_f}",
        "# Layout",
        "layout: album",
        "#--------------",
        "# Custom section",
        "# Index",
        "pos: #{obj.pos}",
        "# Title",
        "title: #{obj.title}",
        "# Main image",
        "main-img: #{img_arr[0]}",
      ] + img_section
    }
    albums = website.albums
    create_content albums, dest, "_albums", obj_to_filename, obj_to_content, true
  end

  #=================================================================================
  # Check in the target directory if one file lives without an existing oject
  # The image version is always medium. See image_uploader.rb
  # Params:
  # +dest+:: the target directory
  # +objects+:: list of objects
  # +to_name+:: path translator for the object
  def check_target_dir dest, objets, &to_name
    obj_files = objets.map &to_name 
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

    if image and image.upload.url 
      img_url = image.upload.url
      dest_path = File.join(dest, img_url)
      dest_dir = File.dirname(dest_path)
      dest_info = File.join(dest_dir, "#{image.updated_at.to_f}")
      if ctrl and File.exists?(dest_info)
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
        if url_match.length == 1 and url_match[0].length == 2
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

  #=================================================================================
  # Clean all images in list in the target path
  # Params:
  # +path+:: target dir to check
  # +image_ids+:: array of images id (string) to keep
  def clean_images path, image_ids
    Dir.glob("#{path}/*/").each do |dir|
      basename = Pathname.new(dir).basename.to_s
      unless image_ids.include? basename
        FileUtils.rm_rf dir
      end
    end
  end


  #========================================================
  # Copy the static content
  # Copy the directory structure of static content of the model
  # Params:
  # +target+:: the target directory
  # +erase+:: erase
  def copy_static_content prototype, target, erase=false

    paths = [
      #path.join('assets'),
      #path.join('css'),
      target.join('_posts'),
      target.join('_themes'),
      target.join('_infos'),
      target.join('_albums')
    ]
    FileUtils.mkdir_p(paths)
    ['_sass', '_themes', '_layouts', '_includes', 'assets', 'css', 'fonts'].each do |dir|
      dest = File.join(target, dir)
      if !File.directory?(dest)
        #FileUtils.remove_dir(dest, true)
        FileUtils.cp_r(
          Rails.root.join("prototype", prototype, dir), 
          dest)
      end
    end
    ['Gemfile', '.gitignore'].each do |file|
      src = Rails.root.join("prototype", prototype, file)
      dest = Rails.root.join(target, file)
      if File.exist? src
        FileUtils.cp_r src, dest
      end
    end
  end

  #========================================================
  # Check directory structure
  # Params:
  # +file+::
  # +created+::
  # +updated+::
  def is_new file, created, updated 
    if !file.exist?
      return true
    end
    yaml = YAML.load_file(file)
    if !yaml
      return true
    end
    y_created = yaml['created']
    y_updated = yaml['updated']
    return y_created != created.to_f || y_updated != updated.to_f
  end

end

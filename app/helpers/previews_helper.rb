#========================================================
# Helper for generating the website preview and running
# Jekyll. 
#========================================================
module PreviewsHelper

  #========================================================
  # Kill the process exists sending ctrl-c
  # 
  # Params:
  # +pid+:: pid of the process
  def kill_process pid
    Process.kill "INT", pid
    true
  rescue Errno::ESRCH
    false
  end

  #========================================================
  # Test if the process exists
  # 
  # Params:
  # +pid+:: pid of the process
  def process_exists pid
    Process.kill 0, pid
    true
  rescue Errno::ESRCH
    false
  end

  #========================================================
  # Get the destination path of the preview
  # 
  # Params:
  # +preview+:: the site preview
  def get_dest_path preview
    conf = Rails.configuration.scribae['preview']
    return Rails.root.join(
      conf['target'], 
      preview.id.to_s)
  end

  #========================================================
  # Create config
  # 
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def create_config website, dest

    config = {
      "title" => "#{website.project}",
      "lang" => "",
      "email" => "",
      "description" => "#{website.description}",
      "repository" => '',
      "baseurl" => "",
      "url" => "",
      "markdown" => "kramdown",
      "sass" => {
        "style" => "expanded"
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

  #========================================================
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
      return updated
    end
  end
  
  #========================================================
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
      copy_image top_image, dest, true
      bottom_image = Image.where({
        imageable_type: 'Website',
        imageable_id: website.id,
        name: 'bottom'
      }).first
      copy_image bottom_image, dest, true
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

  #========================================================
  # Create articles pages
  # 
  # Params:
  # +website+:: the site id
  # +dest+:: the site id
  def create_articles website, dest
    articles = website.articles.select { |article| !article.fake }
    obj_to_filename = lambda { |article|
      "#{article.date.year}-#{article.date.month}-#{article.date.mday}-#{article.id}.md" 
    }
    check_target_dir Rails.root.join(dest, "_posts"), articles, &obj_to_filename

    articles.each do |article|
      path = Rails.root.join(dest, "_posts", obj_to_filename[article])
      exists = File.file?(path)
      update = is_new path, article.created_at, article.updated_at
      main_img = Image.where({
        imageable_type: 'Article',
        imageable_id: article.id,
        category: 'main'
      }).first

      copy_main = nil
      copy_main = copy_image main_img, dest
      
      if !exists or update

        copy_content_image article.markdown, dest
        file = File.open(path, "w")
        head = [
          "---",
          "#--------------",
          "# Article model",
          "#--------------",
          "# Fixed section do not modify",
          "# Creation date",
          "created: #{article.created_at.to_f}",
          "# Last update",
          "updated: #{article.updated_at.to_f}",
          "# Layout",
          "layout: post",
          "#--------------",
          "# Custom section",
          "# Publication date",
          "date: #{article.date}",
          "# Title",
          "title: #{article.title}",
          "# Introduction text",
          "intro: #{article.intro}",
          "# Main image",
          "main-img: #{copy_main}",
          "# If the article is show on home page",
          "featured: #{article.featured}",
          "# Categories",
          "categories: ",
          "---"
        ].join("\n") + "\n"
        file << head
        file << "#{article.markdown}\n"
        file.close
        
      end
    end
  end

  #========================================================
  # Create themes pages
  # 
  # Params:
  # +website+:: the website
  # +dest+:: the destination path
  def create_themes website, dest
    themes = website.themes
    obj_to_filename = lambda { |theme|
      "theme-#{theme.id}.md" 
    }
    #clean target directory
    check_target_dir Rails.root.join(dest, "_themes"), themes, &obj_to_filename

    themes.each do |theme|
      path = Rails.root.join(dest, "_themes", obj_to_filename[theme])
      exists = File.file?(path)
      update = is_new path, theme.created_at, theme.updated_at
      main_img = Image.where({
        imageable_type: 'Theme',
        imageable_id: theme.id,
        category: 'main'
      }).first

      copy_main = nil
      copy_main = copy_image main_img, dest
      
      if !exists or update

        copy_content_image theme.markdown, dest
        file = File.open(path, "w")
        head = [
          "---",
          "#--------------",
          "# Theme model",
          "#--------------",
          "# Fixed section do not modify",
          "# Creation date",
          "created: #{theme.created_at.to_f}",
          "# Last update",
          "updated: #{theme.updated_at.to_f}",
          "# Layout",
          "layout: theme",
          "#--------------",
          "# Custom section",
          "# Index",
          "pos: #{theme.pos}",
          "# Title",
          "title: #{theme.title}",
          "# Introduction text",
          "intro: #{theme.intro}",
          "# Main image",
          "main-img: #{copy_main}",
          "# Categories",
          "categories: ",
          "---"
        ].join("\n") + "\n"
        file << head
        file << "#{theme.markdown}\n"
        file.close
        
      end
    end
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
  # Copy a specific image object to the preview folder
  # The image version is always medium. See image_uploader.rb
  # Params:
  # +image+:: the image model
  # +dest+:: the preview path
  def copy_image image, dest, all=false

    if image and image.upload.url 
      img_url = image.upload.url
      dest_path = File.join(dest, img_url)
      dest_dir = File.dirname(dest_path)
      dest_info = File.join(dest_dir, "#{image.updated_at.to_f}")
      if File.exists?(dest_info)
        return false
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
      info_file = File.new(dest_info, "w")
      info_file.close
      return true
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
  # Params:
  # +markdown+:: the mardown text
  # +dest+:: the preview path
  def copy_content_image markdown, dest
    if markdown.nil?
      return
    end
    url_regex = /upload\/images\/[a-zA-Z]+\/(\d+)\/(\d+)+\/m_img.jpg/
    img_regex = /!\[{s:(\d+),a:"(c|l|r)",o:"(.*)"}\]\(\/(.*)\)/
    res = markdown.scan img_regex
    res.each do |scan| 
      if scan.length == 4
        url = scan[3]
        url_match = url.scan url_regex
        if url_match.length == 1 && url_match[0].length == 2
          src_path = Rails.root.join("public", url)
          dest_path = File.join(dest, url)
          if !dest_path.exists?
            FileUtils.mkdir_p(File.dirname(dest_path))
            FileUtils.cp src_path, dest_path
          end
        end
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
      target.join('_info'),
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
    ['Gemfile'].each do |file|
      FileUtils.cp_r(
        Rails.root.join("prototype", prototype, file), 
        Rails.root.join(target, file))
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
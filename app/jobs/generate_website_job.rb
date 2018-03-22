require 'fileutils'
require 'yaml'

class GenerateWebsiteJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    site_id = args[0]
    check_dir site_id
    website = Website.find(site_id)
    gen_home website
    gen_comps website
    gen_config website
  end

  private
    def gen_config website
      path = Rails.root.join("deploy", "#{website.id}", "_config.yml")
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
        "paginate_path" => "/posts/page-:num/"
      }
      File.open(path,'w') do |f| 
        f.write config.to_yaml
      end
    end
    
    def gen_comps website
      comps = website.components
      comps.each do |comp|
        if(comp.name == 'articles')
          FileUtils.mkdir_p(Rails.root.join("deploy", "#{website.id}", "posts"))
          path = Rails.root.join("deploy", "#{website.id}", "posts", "index.html")
        else
          path = Rails.root.join("deploy", "#{website.id}", "#{comp.name}.md")
        end
        if is_new path, website.created_at, website.updated_at
          file = File.open(path, "w")
          head = [
            "---",
            "#--------------",
            "# Modèle composant",
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
            "# Theme spécifique (couleur en fonction de l'ordre de la page)",
            "theme: 2",
            "# Titre de la page",
            "title: #{comp.title}",
            "# Icone de la page",
            "icon: #{comp.icon}",
            "# Icone de la page",
            "icon-color: #{comp.icon_color}",
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
      ensure
        if file
          file.close
        end
      end
    end
    
    # Generate home page index.md for a website
    # Check if the same page already exists
    # Params:
    # +website+:: The website
    def gen_home website
      path = Rails.root.join("deploy", "#{website.id}", "index.md")
      if is_new path, website.created_at, website.updated_at
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
          "# Titre principal sur la deuxième image",
          "bottom-title: #{website.bottom_title}",
          "# Texte en sous titre",
          "bottom-intro: #{website.bottom_intro}",
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

    # Check directory structure
    # Params:
    # +site_id+::
    def check_dir site_id

      path = Rails.root.join('deploy', site_id)
      paths = [
        #path.join('assets'),
        #path.join('css'),
        path.join('_posts'),
        path.join('_themes'),
        path.join('_info'),
        path.join('_albums')
      ]
      FileUtils.mkdir_p(paths)
      ['_sass', '_themes', '_layouts', '_includes', 'assets', 'css', 'fonts', 'images'].each do |dir|
        dest = Rails.root.join('deploy', site_id, dir)
        if !File.directory?(dest)
          #FileUtils.remove_dir(dest, true)
          FileUtils.cp_r(
            Rails.root.join('deploy', 'model', dir), 
            dest)
        end

      end
      #['Gemfile', 'Rakefile'].each do |file|
      #  FileUtils.cp_r(
      #    Rails.root.join('deploy', 'model', file), 
      #    Rails.root.join('deploy', site_id, file))
      #end
    end

    # Check directory structure
    # Params:
    # +file+::
    # +created+::
    # +created+::
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

    def get_deploy_path site_id
      return Rails.root.join('deploy', site_id)
    end

end

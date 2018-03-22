require 'fileutils'

class JekyllJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    #Rails.logger = Logger.new(STDOUT)
    site_id = args[0]
    website = Website.find(site_id)
    path = Rails.root.join("deploy", "#{website.id}")
    #options = {
    #  'baseurl' => '/',
    #  'watch' => true,
    #  'port' => 4000,
    #}
    #Dir.chdir path do
    #  Jekyll::Commands::Build.process(options)
    #  Jekyll::Commands::Serve.process(options)
    #end 

    # generate the site
    #Jekyll::Site.new(
    #  Jekyll.configuration({
    #    "config" => Rails.root.join("deploy", "#{website.id}", "_config.yml").to_s,
    #    "source" => Rails.root.join("deploy", "#{website.id}").to_s,
    #    "destination" => Rails.root.join("deploy", "#{website.id}", "site").to_s
    #  })
    #).process
    #Rails.logger.info "\e[0;32;49mJekyll site built!\e[0m]]"
    #rescue => e
    #Rails.logger.error "\e[0;31;49mJekyll site build failed.\e[0m\n\e[0;33;49mError:\e[0m #{e}"
    
    #FileUtils.chdir(path)
    Bundler.with_clean_env do
      Dir.chdir path do
        pid = spawn( "bundle exec jekyll serve --livereload", [:out, :err]=>["jekyll.log", "w"])
        Process.detach pid
      end  
    end
    
    #pid = spawn( "pwd")
    ##pid = spawn( "bundle", "update")
    #Process.wait pid
    #pid = spawn( "pwd")
    #pid = spawn( "jekyll", "-v")
    #pid = spawn( "bundle", "exec", "jekyll", "serve", "--watch")
    #puts "jekyll pid #{pid}"
    #Process.wait pid
  end


end
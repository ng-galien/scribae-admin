#========================================================
# Helper module for git manipulation
# 
#========================================================
require 'fileutils'
require 'github_api'
require 'pp'
require 'open3'
require 'os'

module GitHelper
  
  include TerminalHelper

  #========================================================
  # Kill the process exists sending ctrl-c
  # 
  # Params:
  # +pid+:: pid of the process
  def git_setup gitconfig, password 

    terminal_add gitconfig, terminal_trigger(I18n.t('git.trigger.init'), "")
    terminal_add gitconfig, terminal_info(I18n.t('git.message.init'))

    cmd_res = false
    #Github client
    github = Github.new basic_auth: "#{gitconfig.user}:#{password}"
    #SSH key setup
    keys = github.users.keys.list.body
    #pp keys
    has_key = keys.select{|key| key.title == gitconfig.repo}.length > 0
    unless has_key
      option = OS.mac? ? "-K" : ""
      key_path = File.absolute_path "#{Dir.home}/.ssh/#{gitconfig.repo}"
      key_exists = File.exist? key_path
      
      unless key_exists
        
        terminal_add gitconfig, terminal_info(I18n.t('git.message.ssh'))
        cmds = [
          ["ssh-keygen -t rsa -b 4096 -f ~/.ssh/#{gitconfig.repo} -C \"#{gitconfig.email}\" -q -N \"\"", nil, true],
          ["eval \"$(ssh-agent -s)\"", /Agent pid (\d*)/, true],
          ["ssh-add #{option} ~/.ssh/#{gitconfig.repo}", /Identity added: (.*)/, true]
        ]
        cmd_res = run_commands cmds, gitconfig
      end
      has_key = cmd_res && File.exist?(key_path)
      if has_key
        # Get the ssh key
        out, status = Open3.capture2e("cat ~/.ssh/#{gitconfig.repo}.pub")
        if status.success?
          # Create add ssh key to github
          res = github.users.keys.create "title": gitconfig.repo, "key": out
          cmds = [
            ["ssh -T -q git@github.com", /Hi (.*)! You've successfully authenticated, but GitHub does not provide shell access./, true]
          ]
          cmd_res = run_commands cmds, gitconfig
        end
      end
    end

    # Change dir to preview path
    preview_dir = Rails.configuration.scribae['preview']['target']
    repo_path = Rails.root.join(preview_dir, gitconfig.repo)
    unless Dir.exist? repo_path
      FileUtils.mkdir_p repo_path
    end
    Dir.chdir repo_path

    # Get repo on github
    repos = github.repos.list.body
      .select{|repo| repo.name == gitconfig.repo}
    unless repos.length == 1
      # Create the repo
      terminal_add gitconfig, terminal_info(I18n.t('git.message.create'))
      github_res = github.repos.create name: gitconfig.repo
      repo = github_res.body

    else
      repo = repos[0]
    end

    # Configure the git repository 
    terminal_add gitconfig, terminal_info(I18n.t('git.message.configure'))
    cmds = [
      ["echo \"# Scribae project\" >> README.md"],
      ["git init", nil, true],
      ["git add README.md", nil, true],
      ["git commit -m \"first commit\"", nil, true],
      ["git config user.name \"#{gitconfig.user}\"", nil, true],
      ["git config user.email \"#{gitconfig.email}\"", nil, true],
      ["git remote add origin #{repo.ssh_url}", nil, false],
      ["git push -u origin master", nil, true],
      ["git branch gh-pages", nil, true],
      ["git checkout gh-pages", nil, true]
    ]
    cmd_res = run_commands cmds, gitconfig
    puts "CMD_RES => #{cmd_res}"
    # Save the config
    
    if cmd_res
      gitconfig.initialized = true
      gitconfig.repo_link = repo.html_url
      gitconfig.website_link = "https://#{gitconfig.user}.github.io/#{gitconfig.repo}"
      gitconfig.save!
      terminal_add gitconfig, terminal_trigger(I18n.t('git.trigger.created'), "")
    end
  end
  
  #========================================================
  # Commit the project repo
  # 
  # Params:
  # +cmds+:: message of the log 
  def git_commit gitconfig
    #change dir to preview path
    terminal_add gitconfig, terminal_info(I18n.t('git.message.commit'))
    preview_dir = Rails.configuration.scribae['preview']['target']
    repo_path = Rails.root.join(preview_dir, gitconfig.repo)
    if Dir.exist? repo_path
      Dir.chdir repo_path
      cmds = [
        ["git add .", nil, false],
        ["git commit -m \"gh-pages commit\"", nil, false],
        ["git push origin gh-pages", nil, true]
      ]

      cmd_res = run_commands cmds, gitconfig
      if cmd_res
        terminal_add gitconfig, terminal_trigger(I18n.t('git.trigger.commited'), "")
      end
    end
  end

  #========================================================
  # Run an array of commands
  # 
  # Params:
  # +cmds+:: message of the log   
  def run_commands cmds, logs_end_point
    cmds.each do |arr|
      cmd = arr[0]
      regex = arr[1]
      ctrl_status = arr[2]
      terminal_add logs_end_point, terminal_cmd(cmd)
      out, status = Open3.capture2e(cmd)
      terminal_add logs_end_point, terminal_cmd(out)
      if ctrl_status
        unless status.success?
          return false
        end
      end
      unless regex.nil?
        match = regex.match out
        if match.nil?
          return false
        end
      end
    end
    true
  end
  
end
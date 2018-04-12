#========================================================
# Helper for generating the website preview and running
# Jekyll. 
#========================================================
module TerminalHelper

  INFO = 0
  ERROR = 10
  CMD = 20
  TRIGGER = 30
  
  def terminal_log end_point, log
    end_point.terminal_logs << log
  end
  #========================================================
  # Create a log object for git message
  # 
  # Params:
  # +message+:: message of the log
  def terminal_message helper, info, message 
    TerminalLog.new do |log|
      log.helper = helper
      log.info = info
      log.message = message
    end
  end

  #========================================================
  # Create a log object for git terminal command
  # 
  # Params:
  # +message+:: message of the log 
  def  terminal_info message
    terminal_message INFO, "info", message
  end

  #========================================================
  # Create a log object for jekyll message
  # 
  # Params:
  # +message+:: message of the log
  def terminal_error message
    terminal_message ERROR, "error", message
  end

  #========================================================
  # Create a log object for jekyll message
  # 
  # Params:
  # +message+:: message of the log
  def terminal_cmd message
    terminal_message CMD, "cmd", message
  end

  #========================================================
  # Create a log object for jekyll message
  # 
  # Params:
  # +message+:: message of the log
  def terminal_trigger trigger, data
    terminal_message TRIGGER, trigger, data
  end
end

  #45 k€
  #motivation
  #connaissance projet/produit
  #boite à outils 
  #flexible


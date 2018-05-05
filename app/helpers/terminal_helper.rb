#========================================================
# Helper for generating Terminal logs
# 
#========================================================
module TerminalHelper

  INFO = 0
  ERROR = 10
  CMD = 20
  TRIGGER = 30

  #========================================================
  # Add a log object to an endpoint which contains a TerminalLog list
  # 
  # Params:
  # +end_point+:: the end point which logs are inserted
  # +log+:: the log object
  def terminal_add end_point, log
    end_point.terminal_logs << log
  end

  #========================================================
  # Create a log object
  # 
  # Params:
  # +helper+:: helper of the log
  # +info+:: info of the log
  # +message+:: message of the log
  def terminal_message helper, info, message 
    TerminalLog.new do |log|
      log.helper = helper
      log.info = info
      log.message = message
    end
  end

  #========================================================
  # Shorthand for info type TerminalLog
  # 
  # Params:
  # +message+:: message of the log 
  def  terminal_info message
    terminal_message INFO, "info", message
  end

  #========================================================
  # Shorthand for error type TerminalLog
  # 
  # Params:
  # +message+:: message of the log
  def terminal_error message
    terminal_message ERROR, "error", message
  end

  #========================================================
  # Shorthand for command type TerminalLog
  # 
  # Params:
  # +message+:: message of the log
  def terminal_cmd message
    terminal_message CMD, "cmd", message
  end

  #========================================================
  # Shorthand for trigger type TerminalLog
  # 
  # Params:
  # +trigger+:: message of the log
  # +data+:: data of the log
  def terminal_trigger trigger, data
    terminal_message TRIGGER, trigger, data
  end
end



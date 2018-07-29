module ProcessHelper
  #=================================================================================
  # Kill the process exists sending ctrl-c
  # 
  # Params:
  # +pid+:: pid of the process
  def process_stop pid
    Process.kill "INT", pid
    true
  rescue Errno::ESRCH
    false
  end

  #=================================================================================
  # Test if the proces  s exists
  # 
  # Params:
  # +pid+:: pid of the process
  def process_exists? pid
    Process.kill 0, pid
    true
  rescue Errno::ESRCH
    false
  end


  #========================================================
  # Run an array of commands
  # 
  # Params:
  # +cmds+:: message of the log   
  # logs_end_point:: the root for logging
  def run_commands cmds, logs_end_point=nil
    cmds.each do |arr|

      cmd = arr[0]
      regex = arr[1]
      ctrl_status = arr[2]
      unless logs_end_point.nil?
        terminal_add logs_end_point, terminal_cmd(cmd)
      end
      out, status = Open3.capture2e(cmd)
      unless logs_end_point.nil?
        terminal_add logs_end_point, terminal_cmd(out)
      end
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
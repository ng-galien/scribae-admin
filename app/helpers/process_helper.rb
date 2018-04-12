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
end
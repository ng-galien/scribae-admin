class Preview < ApplicationRecord
  
  include ProcessHelper
  
  include Loggable
  belongs_to :website

  def set_starting pid
    self.process = pid
    self.status = 10
    self.save!
  end

  def set_started
    self.status = 20
    self.save!
  end

  def set_stopped
    self.status = 0
    self.process = 0
    self.save!
  end

  def is_stopped?
    !! (self.status == 0 and self.process == 0)
  end

  def is_running?
    !! (self.status == 20 and self.process > 0)
  end

  def is_starting? 
    !! (self.status > 0  and !self.running?)
  end

  def stop
    if process_exists? self.process
      ActiveSupport::Dependencies.interlock.permit_concurrent_loads do
        process_stop self.process
        self.set_stopped
        self.terminal_logs.destroy_all
      end
    end
  end

end

#=================================================================================
class Preview < ApplicationRecord
  
  include ProcessHelper
  
  include Loggable
  belongs_to :website

  #=================================================================================
  def set_starting process
    puts "set pid #{process}"
    self.process = process
    self.status = 10
    self.save!
  end

  #=================================================================================
  def set_started
    self.status = 20
    self.save!
  end

  #=================================================================================
  def is_stopped?
    !! (self.status == 0 && self.process == 0)
  end

  #=================================================================================
  def is_started?
    !! (self.status == 20 && self.process > 0)
  end

  #=================================================================================
  def is_starting? 
    !! (self.status > 0  && !self.is_started?)
  end

  #=================================================================================
  def stop
    if !self.process.nil? && self.process > 0
      if process_exists? self.process
        process_stop self.process
        self.process = 0
        self.status = 0
        self.save!
      end
    end
    self.process = 0
    self.status = 0
    self.save!
  end

end

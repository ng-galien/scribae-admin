#=================================================================================
# Style record 
# 
#=================================================================================
class Style < ApplicationRecord
  belongs_to :stylable, polymorphic: true

  def to_scss
    scss = []
    self.attributes.each do |key, value|
      unless [
        'id', 
        'stylable_type', 
        'stylable_id', 
        'created_at',
        'updated_at',
        'helper'
      ].include?(key)
        scss << "$scribae-#{self.class.name.downcase}-#{key}: #{value};"
      end
      scss << "#{self.helper}"
    end
    scss.join("\n")
  end

end

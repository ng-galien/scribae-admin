module StylesConcern
  extend ActiveSupport::Concern
  
  included do
  
    def default_style
      style = Style.new do |s|
        s.primary = ''
        s.secondary = ''
        s.background = ''
        s.icon = ''
        s.text = ''
        s.decoration = ''
      end
      return style
    end
  end
  
end
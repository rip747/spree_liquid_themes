class Liquid::Strainer
  
  def controller
    @controller ||= @context.registers[:controller]
  end
  
  delegate :request, :to => :controller
  delegate :params, :to => :request
  
end

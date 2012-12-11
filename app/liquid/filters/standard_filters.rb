module StandardFilters
   def current_date(format=nil)
     format.nil? ? Time.now : Time.now.strftime(format.to_s)
   end
end

Liquid::Template.register_filter StandardFilters
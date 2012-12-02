module StandardFilters
   def current_date(format=nil)
     res = Time.now unless format
     res = Time.now.strftime(format.to_s) if format
     res
   end
end

Liquid::Template.register_filter StandardFilters
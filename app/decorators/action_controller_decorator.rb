require "action_view/custom_resolver"

ActionController::Base.class_eval do
#  append_view_path LiquidResolver.new
end
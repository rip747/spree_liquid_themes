ApplicationController.class_eval do
  layout Refinery::Themes::Theme.default_layout

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::RespondWith
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
end
ActionView::Base.class_eval do
  include Refinery::MenuHelper
  include Spree::ProductsHelper
  include Spree::BaseHelper
end
ApplicationController.class_eval do
  before_filter :set_assigns

  private

  def set_assigns
    @assigns
  end
end
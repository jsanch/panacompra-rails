class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_count

  
  protected 

  def load_count
    @count = Rails.cache.fetch("count", :expires_in => 5.minutes) {Compra.count}
  end

  def initialize_many_from_json
    array = []
    params[:_json].each do |object|
      new_object = controller_name.classify.constantize.new
      new_object.assign_attributes(object , :without_protection => true)
      array << new_object
    end
    array
  end

end

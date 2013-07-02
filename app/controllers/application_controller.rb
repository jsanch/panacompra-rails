class ApplicationController < ActionController::Base
  protect_from_forgery

  protected 

  def initialize_many_from_json
    array_of_objects = []
    params[:_json].each do |object|
      new_object = controller_name.classify.constantize.new
      new_object.assign_attributes(object , :without_protection => true)
      array_of_objects << new_object
    end
    array_of_objects
  end

end

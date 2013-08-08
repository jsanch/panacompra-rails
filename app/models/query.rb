class Query < ActiveRecord::Base
  attr_accessible :entidad, :price_max, :price_min, :query, :ip, :category_id, :user_id, :empty
  belongs_to :user
  belongs_to :category
end

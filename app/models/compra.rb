class Compra < ActiveRecord::Base
  attr_accessible :acto, :categoria, :compra_id, :description, :entidad, :fecha, :precio, :proponente, :url, :category_id

  belongs_to :category

  include PgSearch
  pg_search_scope :search, against: [:entidad, :proponente, :description],
    using: {tsearch: {dictionary: "spanish", prefix: true}},
    ignoring: :accents,
    associated_against: {category: :name}
  
  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def detect_and_mark_done
    if self.proponente == nil
      self.done = true
    else
      self.done = false
    end
  end


end

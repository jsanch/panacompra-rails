class Compra < ActiveRecord::Base
  attr_accessible :acto, :categoria, :compra_id, :description, :entidad, :fecha, :precio, :proponente, :url, :category_id

  belongs_to :category
  after_create :trigger_alerts

  include PgSearch
  pg_search_scope :search, against: [:proponente, :description],
    ignoring: :accents

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

  def trigger_alerts
    Alert.all.each do |alert|
      AlertMailer.compra_alert(self).deliver if alert.detect(self)
    end
  end


end

class Compra < ActiveRecord::Base
  attr_accessible :acto, :categoria, :compra_id, :description, :entidad, :fecha, :precio, :proponente, :url, :category_id

  validates_uniqueness_of :acto
  validates_uniqueness_of :url

  validates_presence_of :category_id
  validates_presence_of :fecha
  validates_presence_of :proponente
  validates_presence_of :entidad
  validates_presence_of :acto
  validates_presence_of :url
  validates_presence_of :description
  validates_presence_of :precio

  belongs_to :category
  after_create :trigger_alerts

  include PgSearch
  pg_search_scope :search, against: [:description, :proponente],
    using: {
      tsearch: {dictionary: 'spanish', prefix: true, tsvector_column: 'tsv_description'},
    },
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
      AlertMailer.compra_alert(self,alert.user.email).deliver if alert.detect(self)
    end
    #Delayed::Job.enqueue(AlertJob.new(self.id))
  end

  def self.total_by_day(start=1.week.ago)
    compras = where(fecha: start.beginning_of_day..Time.zone.now)
    compras = compras.group("date(fecha)")
    compras = compras.select("date(fecha), sum(precio) as total_price")
    compras
  end


end

class Compra < ActiveRecord::Base
  default_scope where('parsed = true and fecha is not null')
  attr_accessible :acto, :description, :entidad, :fecha, :precio, :proponente, :url, :category_id, :modalidad, :dependencia, :provincia, :compra_type, :nombre_contacto, :telefono_contacto, :correo_contacto, :objeto, :unidad, :precio_cd 

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
  validates_presence_of :precio_cd
  validates_presence_of :correo_contacto

  belongs_to :category
  after_create :trigger_alerts

  include PgSearch
  pg_search_scope :search, against: [:description, :proponente],
    using: {
      tsearch: { tsvector_column: 'tsv_description'},
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

  def full_url
    "http://panamacompra.gob.pa/AmbientePublico/" + self.url
  end


end

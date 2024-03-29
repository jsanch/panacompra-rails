class Alert < ActiveRecord::Base
  attr_accessible :descripcion, :entidad, :precio_max, :precio_min
  belongs_to :user

  def detect(compra)
    
    (return false if (compra.precio < self.precio_min or self.precio_min == '')) if self.precio_min
    (return false if (compra.precio > self.precio_max or self.precio_max =="")) if self.precio_max
    (return false if (compra.entidad != self.entidad unless (self.entidad == '' ))) if self.entidad
    (return false if (not (ActiveSupport::Inflector.transliterate(compra.description).downcase.include? self.descripcion.downcase or self.descripcion == ''))) if self.descripcion
    return true
  end

end

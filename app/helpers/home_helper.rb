module HomeHelper

  def entidad_chart_data 
    (Compra.sum(:precio, :group => :entidad)).map do |entidad,precio|
      [ entidad,precio.to_f ] 
    end
  end

end

module HomeHelper

  def entidad_chart_data 
    Rails.cache.fetch("entidad_chart_data", :expires_in => 5.minutes) do
      (Compra.sum(:precio, :group => :entidad)).map do |entidad,precio|
        [ entidad,precio.to_f ] 
      end
    end
  end

  def total_por_dia_data
    Rails.cache.fetch("total_por_dia_data", :expires_in => 5.minutes) do
      (Compra.total_by_day(4.year.ago)).map do |compra_date|
        [ 
          compra_date.date.strftime('%b %d, %Y'),
          compra_date.total_price.to_f
        ] 
      end.unshift(['Fecha','Precio'])
    end
  end

end

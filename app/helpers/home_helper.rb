module HomeHelper

  def proponente_chart_data 
    (Compra.sum(:precio, :group => :proponente)).map do |proponente,precio|
      [ proponente,precio ] 
    end
  end

end

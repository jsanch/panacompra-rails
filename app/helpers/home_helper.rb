module HomeHelper

  def compra_chart_data
    (Compra.select("DISTINCT(PROPONENTE)").where('proponente != ?', 'empty')).map do |compra|
      [ 
        compra.proponente,
        Compra.where("proponente = ?",compra.proponente).sum(:precio).to_f
      ] 
    end
  end


end

class AlertMailer < ActionMailer::Base
  default from: "panacompra.herokuapp.com"

  def compra_alert(compra,to)
    @compra = compra
    mail(:to => to, :subject => "Compra Alert")
  end
end

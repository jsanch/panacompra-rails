class AlertMailer < ActionMailer::Base
  default from: "panacompra.net"

  def compra_alert(compra,to)
    @compra = compra
    mail(:to => to, :subject => "Compra Alert: #{@compra.acto}")
  end
end

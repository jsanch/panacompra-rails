class AlertMailer < ActionMailer::Base
  default from: "panacompra.herokuapp.com"

  def compra_alert(compra)
    mail(:to => 'ibarria0@gmail.com', :subject => "Compra Alert")
  end
end

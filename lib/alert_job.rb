class AlertJob < Struct.new(:compra_id)
  def perform
    compra = Compra.find(compra_id)
    Alert.all.each do |alert|
      AlertMailer.compra_alert(compra,alert.user.email).deliver if alert.detect(compra)
    end
  end
end

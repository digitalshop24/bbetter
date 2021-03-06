class YandexKassaController < ActionController::Base
  #before_filter :find_order

  def testcheck
    p "here1"
    check_order = YandexKassa::CheckOrder.new(params)
    p "here2"
    render text: check_order.response
    puts "here3"
  end

  def testpay
    aviso = YandexKassa::PaymentAviso.new(params)
    if aviso.valid_signature?
      tariff = Tariff.find(params["tariffId"])
      if params["orderSumAmount"].to_i == tariff.price.to_i
        user = User.find(params["customerNumber"])
        UserTariff.create(user: user, tariff: tariff)
        if tariff.people_number > 1
          Promocode.available.limit(tariff.people_number - 1).update_all(referrer_id: user.id)
        end
      end
    end
    render text: aviso.response
  end

  def success
    # Платеж на сайте Яндекс.Кассы успешно завершен, клиент вернулся на ваш
    # сайт по ссылке "Вернуться в магазин".
    # В зависимости от выбранного способа оплаты, к этому моменту заказ
    # может быть оплачен, а может и нет. Подтверждение оплаты приходит
    # в метод `aviso`
    p "success"
    redirect_to root_url, notice: I18n.t('messages.payment_completed')
  end

  def fail
    # Платеж на сайте Яндекс.Кассы завершился ошибкой оплаты
    p "fail"
    redirect_to root_url, notice: I18n.t('messages.payment_failed')
  end

  private

  # def find_order
  #   @order = Order.find(params[:orderNumber])
  # end
end

class YandexKassaController < ActionController::Base
  #before_filter :find_order

  def testcheck
    check_order = YandexKassa::CheckOrder.new(params)
    render text: check_order.response
  end

  def testpay
    aviso = YandexKassa::PaymentAviso.new(params)
    if aviso.valid_signature?
      UserTariff.create(user_id: params["customerNumber"], tariff_id: params["tariffId"])
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

class YandexKassaController < ActionController::Base
  #before_filter :find_order

  def testcheck
    p "------------------------------------------------------------------------"
    p "------------------------------------------------------------------------"
    p "------------------------------------------------------------------------"
    p params
    p "------------------------------------------------------------------------"
    p "------------------------------------------------------------------------"
    p "------------------------------------------------------------------------"
    check_order = YandexKassa::CheckOrder.new(params)
    p "checked"
    p check_order
    p "!!"
    p check_order.response
    p "??"
    render text: check_order.response
  end

  def testpay
    p "------------------------------------------------------------------------"
    p "------------------------------------------------------------------------"
    p "------------------------------------------------------------------------"
    p params
    p "------------------------------------------------------------------------"
    p "------------------------------------------------------------------------"
    p "------------------------------------------------------------------------"
    aviso = YandexKassa::PaymentAviso.new(params)
    if aviso.valid_signature?
      # Заказ оплачен, платеж поступил на счет Яндекс.Кассы.
      # Здесь нужно поместить код исполнения заказа
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

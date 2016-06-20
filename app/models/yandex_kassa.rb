module YandexKassa
  PARAMS_MAP = {
    requestDatetime: :request_datetime,                   # xs:dateTime Момент формирования запроса в ИС Оператора.
    action: :action,                                      # xs:normalizedString, до 16 символов Тип запроса. Значение: «checkOrder» (без кавычек).
    md5: :md5,                                            # xs:normalizedString, ровно 32 шестнадцатеричных символа, в верхнем регистре MD5-хэш параметров платежной формы, правила формирования описаны в разделе 4.4 «Правила обработки HTTP-уведомлений Контрагентом».
    shopId: :shop_id,                                     # xs:long Идентификатор Контрагента, присваиваемый Оператором.
    shopArticleId: :shop_article_id,                      # xs:long Идентификатор товара, присваиваемый Оператором.
    invoiceId: :invoice_id,                               # xs:long Уникальный номер транзакции в ИС Оператора.
    orderNumber: :order_id,                               # xs:normalizedString, до 64 символов Номер заказа в ИС Контрагента. Передается, только если был указан в платежной форме.
    customerNumber: :customer_number,                     # xs:normalizedString, до 64 символов Идентификатор плательщика (присланный в платежной форме) на стороне Контрагента: номер договора, мобильного телефона и т.п.
    orderCreatedDatetime: :order_created_datetime,        # xs:dateTime Момент регистрации заказа в ИС Оператора.
    orderSumAmount: :order_sum_amount,                    # CurrencyAmount  Стоимость заказа. Может отличаться от суммы платежа, если пользователь платил в валюте, которая отличается от указанной в платежной форме. В этом случае Оператор берет на себя все конвертации.
    orderSumCurrencyPaycash: :order_sum_currency_paycash, # CurrencyCode  Код валюты для суммы заказа.
    orderSumBankPaycash: :order_sum_bank_paycash,         # CurrencyBank  Код процессингового центра Оператора для суммы заказа.
    shopSumAmount: :shop_sum_amount,                      # CurrencyAmount  Сумма к выплате Контрагенту на р/с (стоимость заказа минус комиссия Оператора).
    shopSumCurrencyPaycash: :shopSumCurrencyPaycash,      # CurrencyCode  Код валюты для shopSumAmount.
    shopSumBankPaycash: :shop_sum_bank_paycash,           # CurrencyBank  Код процессингового центра Оператора для shopSumAmount.
    paymentPayerCode: :payment_payer_code,                # YMAccount Номер счета в ИС Оператора, с которого производится оплата.
    paymentType: :payment_type,                           # xs:normalizedString Способ оплаты заказа. Список значений приведен в таблице 6.6.1.
  }
  SIGNATURE_PARAMS = [:order_sum_amount,
    :order_sum_currency_paycash, :order_sum_bank_paycash,
    :shop_id, :invoice_id, :customer_number
  ]

  class Action
    class_attribute :action_name, :shop_id, :password

    self.shop_id = '62054'
    self.password = 'VCFSPuZwxNzqBWyGD6Be'

    attr_reader :params

    def initialize(controller_params)
      @params = map_params(controller_params)
    end

    def valid_signature?
      values = [action_name] + SIGNATURE_PARAMS.map { |name| params[name] } + [password]
      generate_signature(values) == params[:md5]
    end

    def order
      @order ||= Order.find(params[:order_id])
    end

    def response
      raise NotImplementedError
    end

    private

    def map_params(params)
      hashable_array = PARAMS_MAP.map do |param, mapped_param|
        [mapped_param, params[param]]
      end
      HashWithIndifferentAccess[hashable_array]
    end

    def generate_signature(*params)
      Digest::MD5.hexdigest(params.join(';')).upcase
    end
  end

  class CheckOrder < Action

    self.action_name = 'checkOrder'

    def response
      xml = Builder::XmlMarkup.new
      xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'

      xml.checkOrderResponse(performedDatetime: Time.current.iso8601,
        code: code,
        invoiceId: params[:invoice_id],
        shopId: shop_id
      )
      xml.target!
    end

    private

    def code
      if valid_signature?
        valid_params? ? '0' : '100'
      else
        '1'
      end
    end

    def valid_params?
      if order
        order.amount == params[:order_sum_amount].to_i
      else
        false
      end
    end
  end

  class PaymentAviso < Action

    self.action_name = 'paymentAviso'

    def response
      xml = Builder::XmlMarkup.new
      xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'

      xml.paymentAvisoResponse(performedDatetime: Time.current.iso8601,
        code: code,
        invoiceId: params[:invoice_id],
        shopId: shop_id
      )
      xml.target!
    end

    def payment_type
      params[:payment_type]
    end

    private

    def code
      valid_signature? ? '0' : '1'
    end
  end
end

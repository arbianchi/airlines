class FlightsController < ApplicationController
  include PaymentProcessor

  def index 
    @flights = Flight.all
  end

  def checkout 
    @flight = Flight.find(params[:flight])
    @credit_cards = credit_cards
  end

  def purchase
    token = params[:payment_method_token]
    client.retain_payment_method(token) if (params[:retain] === 'true')

    if params[:receiver] === 'true'
      response = deliver_to_receiver(token)
    else
      amount = params[:amount].to_i
      response = purchase_on_gateway(amount, token)
    end

    set_flash_notice(response)
    redirect_to transactions_path
  end

  def transactions
    transactions = []
    results = client.list_transactions
    while results.present? do
      transactions.push(results)
      results = client.list_transactions(results.last.token)
    end
    transactions.flatten!
    @purchases = transactions.select {|t| t.is_a? Spreedly::Purchase}
  end

  def credit_cards
    client.list_payment_methods
  end

  private

  def purchase_on_gateway(amount, token)
    client.purchase_on_gateway(ENV['GATEWAY_TOKEN'], token, amount)
  end

  def deliver_to_receiver(token)
    client.deliver_to_receiver(ENV['RECEIVER_TOKEN'], token,
    headers: headers, body: receiver_body, url: url)
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

  def url
    'https://spreedly-echo.herokuapp.com'
  end

  def receiver_body
    '{"product_id":"916593","card_number":"{{ credit_card_number }}","user_name":"{{user_name}}","secret_password":"{{secret_password}}"}'
  end

  def set_flash_notice(response)
    if response && response.succeeded
      flash[:notice] = 'Thanks for your purchase. Have a great flight!'
    else
      flash[:notice] = "There was a problem with your payment: #{response.message}"
    end
  end

  def client
    client ||= PaymentProcessor.client
  end


end

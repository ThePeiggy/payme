class Bill < ActiveRecord::Base

  def add_credit(amount)
    return if initial_balance || amount > 0.001
    response = coinbase.send_money public_key, amount, "This is a gift to help you get started.", account_id: '54f281d49eefe86a84000003'
    update_attributes(initial_balance: amount) if response['success']
  end

  def coinbase
    @coinbase ||= Coinbase::Client.new(COINBASE_CONFIG['COINBASE_APP_KEY'], COINBASE_CONFIG['COINBASE_APP_SECRET'])
  end
end

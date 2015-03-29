class Bill < ActiveRecord::Base

  def add_credit(amount)
    return false if initial_balance || amount.to_f > 0.001

    response = coinbase.send_money public_key, amount, "This is a gift to help you get started.", account_id: '54f281d49eefe86a84000003'
    return false if !response['success']

    update_attributes(initial_balance: amount)
    return true
  end

  def coinbase
    @coinbase ||= Coinbase::Client.new(COINBASE_CONFIG['COINBASE_APP_KEY'], COINBASE_CONFIG['COINBASE_APP_SECRET'])
  end
end

require 'pry'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def coinbase
    @coinbase ||= Coinbase::Client.new(COINBASE_CONFIG['COINBASE_APP_KEY'], COINBASE_CONFIG['COINBASE_APP_SECRET'])
  end
/
  def cb_bank
    @cb_bank ||= cb_bank = Money::Bank::Coinbase.new.fetch
  end
  /
end

class WalletAccount
  attr_accessor :balance, :currency

  def initialize(currency, balance)
    @currency = currency
	  @balance = balance
  end
  
  def add_money(money)
    self.balance += money
  end
  
  def withdraw(money)
	 self.balance -= money
  end
  
  def self.find_by_currency(currency)
	 where(:currency => currency)
  end
  
  def self.find_balance_by_currency("PLN")
    find_wallet_account(currency).balance
  end
  
  def self.withdraw_money_from_wallet(currency, money)
    find_wallet_account(currency).withdraw(money)
  end
  
  def self.supply_money_to_wallet(currency, money)
    find_wallet_account(currency).add_money(money)
  end
   
end

module WalletTestHelper

  # transfering money
  
  def set_bank_account(bank_name, number, currency, balance)
    @bank_accounts ||= []
    @bank_accounts << BankAccount.new(name, number, currency, balance)	 
  end
  
  def find_bank_account(bank_account_number)
	@bank_accounts.find{ |b| b.number == bank_account_number }
  end
  
  def find_bank_account_currency(bank_account_number)
	find_bank_account(bank_account_number).currency
  end
  
  def set_wallet_balance(wallet_accounts)
    @wallet_accounts ||= []
    wallet_accounts.each do |currency,balance|
      @wallet_accounts << WalletAccount.new(currency,balance)
    end
  end
  
  def transfer_money_to_wallet(bank_account_number, money)
	remove_money_from_bank_account(bank_account_number, money)
	currency = find_bank_account_currency(bank_account_number)
	add_wallet_money(currency, money)
  end
  
  def add_wallet_money(currency, money)
	find_wallet_account(currency).add_money(money)
  end 
  
  def add_money(money)
    self.balance += money
  end
  
  def find_wallet_account(currency)
	@wallet_accounts.find{ |w| w.currency == currency)
  end
  
  def remove_money_from_wallet(currency, money)
    find_wallet_account(currency).withdraw(money)
  end
  
  def remove_money_from_bank_account(bank_account_number, money)
    find_bank_account(bank_account_number).withdraw(money)
  end
  
  def withdraw(money)
	self.balance -= money
  end
  
  def add_bank_account_money(bank_account_number, money)
    find_bank_account(bank_account_number).add_money(money)
  end

  def transfer_all_money_back(bank_account_number)
    currency = find_bank_account_currency(bank_account_number)
    money = get_wallet_balance(currency)
    add_bank_account_money(bank_account_number, money)
    remove_money_from_wallet(currency, money)
  end
  
  # exchanging money
  
  def set_exchange_rate(rates)
    @rates ||= []
    rates.each do |(from_currency,to_currency),rate|
      @rates << ExchangeRate.new(from_currency,to_currency,rate)
    end
  end

  def convert_money(from_currency,to_currency)
    exchanger =
    Exchanger.new(find_account(from_currency),find_account(to_currency),
      find_rate(from_currency,to_currency))
    exchanger.convert(:all)
  end

  def convert_money_with_limit(from_currency,to_currency,limit)
    exchanger =
    Exchanger.new(find_account(from_currency),find_account(to_currency),
      find_rate(from_currency,to_currency))
    exchanger.convert(limit)
  end

  def find_rate(from_currency,to_currency)
    @rates.find{|r| r.from_currency == from_currency &&
        r.to_currency == to_currency}
  end

  # buying and selling stocks

  def set_stock_market(location, currency)
    @stock_markets ||= []
    stock_makrets.each do |location, currency|
      @stock_markets << StockMarket.new(location, currency)
    end
  end
  
  def set_stock_price(stock)
    @stocks ||= []
    stocks.each do |location,(company, price)|
      @stocks << Stock.new(location,company,price)
    end
  end

  def set_company_shares(stock_shares)
    @stock_shares ||= []
    stock_shares.each do |company, share|
      @stock_shares << StockShare.new(company, share)
    end
  end

  def get_company_shares(company)
    @stock_shares.find{|a| a.company == company }
    @stock_shares.share
  end
  
  def buy_stocks(ammount, company, currency)
	stock = @stocks.find(:company=>company)
	remove_money_from_wallet(currency, ammount* stock.price)
	get_company_shares(company) += ammount
  end
  
  def buy_stock_with_limit()
    
  end

  def sell_stocks
  end

  def sell_all_stocks
  end

end
end


# czy w zale¿noœci od lokalizacji gie³dy nale¿y zrobiæ osobne konteksty czy jakoœ uw
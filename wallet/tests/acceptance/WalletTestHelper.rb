module WalletTestHelper

  # transfering money
  
  def set_bank_account_balance(bank, currency, balance)
    @bank_accounts ||= []
    @bank_accounts << BankAccount.new(bank, currency, balance)	 
  end
    
  def set_wallet_balance(wallet_accounts)
    @wallet_accounts ||= []
    wallet_accounts.each do |currency,balance|
      @wallet_accounts << WalletAccount.new(currency,balance)
    end
  end
  
  def transfer_money_to_wallet(bank, currency, money)
    bank_account = find_bank_account(bank,currency)
	  bank_account.withdraw_money(money)
	  wallet_account = find_wallet_account(currency)
	  wallet_account.supply_money_to_wallet(currency, money)
  end    
  
  def find_wallet_account(currency)
     @wallet_accounts.find{|w| w.currency == currency}
  end

  def find_bank_account(bank, currency)
     @bank_accounts.find{|a| a.bank == bank && a.currency == currency}
  end
  
  def transfer_all_money_back(bank, currency)
    money = get_wallet_balance(currency)
    add_bank_account_money(bank, money)
    withdraw_money_from_wallet(currency, money)
  end
  
   # buying and selling stocks

  def set_stock_market(location, currency)
    @stock_markets ||= []
    stock_makrets.each do |location, currency|
      @stock_markets << StockMarket.new(country, currency)
    end
  end
  
  def set_stock_price(stock)
    @stocks ||= []
    stocks.each do |location,(company, price)|
      currency = Market.find_by_location(loaction).currency
      @stocks << Stock.new(company,price, currency)
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
  
  def buy_stocks(amount, company, currency)
    @stock = Stock.find_by_company(company)
    @wallet_account = WalletAccount.find_by_currency(@stock.currency)
    money = amount * @stock.price
    if @wallet_account == nil 
      Wallet_Account.find_by_balance()
    elsif @wallet_account.balance >= money
      buy_company_shares(@stock, amount)
    end
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

end
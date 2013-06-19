describe "wallet_account" do
  include TestHelper
  
  subject(:wallet_account)            { WalletAccount.new(currency, balance) }
  let(:currency)               { "PLN" }
  let(:balance)    { 100 }
  
  
  it "should return amount of money in certain currency" do
    money = WalletAccount.find_balance_by_currency("PLN")
    money.should == 100
  end 
  
  it "should add money in certain currency" do
    WalletAccount.supply_money_to_wallet("PLN", 100)
    
    wallet_account = WalletAccount.find_by_currency("PLN")
    wallet_account.balance.should == 200
  end
  
  it "should withdraw money in certain currency" do  
    WalletAccount.remove_money_from_wallet("PLN", 100)
    
    wallet_account = WalletAccount.find_by_currency("PLN")
    wallet_account.balance.should == 0
  end
  
  

end

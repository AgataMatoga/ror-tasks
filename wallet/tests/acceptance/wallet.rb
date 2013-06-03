describe "wallet" do
  include WalletTestHelper

  context "user with PLN wallet account" do 
  
  specify "can transfer money from bank account to wallet with limit" do
     set_bank_account_balance(:bank, :pln, 200)
     set_wallet_balance :pln => 200
     transfer_money_to_wallet(:pln, 200)
     get_wallet_balance(:pln).should == 400
     get_bank_account_balance(:bank, :pln).should == 0
   end

  specify "can demand all money to be transfered back to his/her bank account"       
     set_bank_account_balance(:bank, :pln, 200)
     set_wallet_balance :pln => 200
     transfer_all_money_back(:bank)
     get_wallet_balance(:pln).should == 0
     get_bank_account_balance(:bank, :pln).should == 400
  end
  
   specify "buying 3 facebook stocks" do
     set_wallet_balance :pln => 60
	 set_stock_price(:pln, "facebook", 20)
     buy_stocks("facebook", 3)
     get_wallet_balance(:pln).should == 0
     get_company_shares("facebook").should == 3
   end

   specify "selling all facebook stocks" do
     set_wallet_balance :pln => 200
     set_company_shares :facebook => 5
     set_stock_price(:pln, "facebook", 20)
     sell_all_stocks(:pln, "facebook")
     get_wallet_balance(:pln).should == 400
     get_company_shares("facebook").should == 0
   end

   specify "selling 3 facebook stocks" do
     set_wallet_balance :pln => 150
     set_company_shares :facebook => 5
     set_stock_price (:pln, "facebook", 20)
     sell_stocks(3, "facebook", :pln)
     get_wallet_balance(:pln).should == 210
     get_company_shares("facebook").should == 2
   end   
  end
  
  
  context "user with PLN and EUR wallet accounts" do
  specify "conversion from EUR to PLN without limit" do
      set_wallet_balance :eur => 100, :pln => 0
      set_exchange_rate [:eur,:pln] => 4.15
      convert_all_money(:eur,:pln)
      get_wallet_balance(:eur).should == 0
      get_wallet_balance(:pln).should == 415
  end

  specify "conversion from EUR to PLN with limit set to 50" do
      set_wallet_balance :eur => 100, :pln => 0
      set_exchange_rate [:eur,:pln] => 4.15
      convert_money_with_limit(:eur,:pln,50)
      get_wallet_balance(:eur).should == 50
      get_wallet_balance(:pln).should == 207.5
  end 
  end
  
end

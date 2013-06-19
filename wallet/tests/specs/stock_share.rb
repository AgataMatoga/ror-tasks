describe "stock_share" do
  include TestHelper
  
  it "should find number of stocks of certain company" do
    company_shares = StockShare.find_company_shares("Facebook")
    company_shares.share.should == 5
  end
  
  it "should supply stock shares" do
    StockShare.supply_stock("Facebook", 5)
  end
  
  it "should withdraw stock shares" do
    
  end
  
  
end
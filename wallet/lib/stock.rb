class Stock
  attr_accessor :company, :price, :market_id
  
  belongs_to :market
  
  def market
    Market.find_by_id(self.market_id)
  end
  
  def self.find_by_company(company)
    where(:company => company).first  
  end
  
  def currency
    find_by_company(self.company).market.currency
  end
   
end

class Market
  attr_accessor :country, :currency
  
  has_many :stocks
  
  def self.find_by_id(id)
    where(:id => id)  
  end
  
  def self.find_by_currency(currency)
    where(:currency => currency)
  end
end

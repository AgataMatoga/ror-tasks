require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/bank_account'
require_relative '../lib/exceptions'

describe BankAccount do
  subject(:bank_account)            { BankAccount.new(:balance, :currency, :bank_name) }
  let(:balance)    { 400 }
  let{:currency}	{ :PLN }
  let{:bank_name}   { "mbank" }

  it { should be_empty }

  it "should raise an exception when nil is passed to the constructor" do
    expect { BankAccount.new(nil) }.to raise_error(IllegalArgument)
  end

  it "should return balance" do
    
  end
 
  it "should add money to balance" do
    
  end
end

require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/bank_account'
require_relative '../lib/exceptions'

describe BankAccount do
  subject(:bank_account)            { BankAccount.new(:number, :balance, :currency, :bank_name) }
  let(:number)               { 1234 5677 8965 2245 1234 12 }
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

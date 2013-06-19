require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/market'
require_relative '../lib/exceptions'

describe Market do
  subject(:bank_account)            { Market.new(:country, :currency) }
  let(:country)    { Poland }
  let{:currency}	{ :PLN }



end
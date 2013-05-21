require 'bundler/setup'
require 'rspec/expectations'
require_relative '../lib/virtual_wallet'
require_relative '../lib/exceptions'

describe Virtual_wallet do
  subject(:virtual_wallet)            { Virtual_wallet.new }
  
end

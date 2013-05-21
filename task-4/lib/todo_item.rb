require 'active_record'

class TodoItem < ActiveRecord::Base
  belongs_to :todolist
  validates :title, :list_id, :presence => true
  validates :title, :greater_than_or_equal_to => 
:5, :less_than_or_equal_to => :30
  validates :description, :less_than_or_equal_to => :255
  validates :format => { :with => /\A\d{2}\/\d{2}\/\d{4}\z/ }
end


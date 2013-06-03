require 'active_record'

class TodoList < ActiveRecord::Base

  attr_accessible :title, :user_id

  belongs_to :user
  has_many :todo_items

  validates :title, :user_id, :presence => true
end


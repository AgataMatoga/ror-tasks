require 'active_record'

class TodoList < ActiveRecord::Base

  attr_accessible :title, :user_id

  belongs_to :user
  has_many :todo_items

  validates :title, :user_id, :presence => true
  
  def self.find_by_title_prefix(prefix)
    where("title LIKE ?", "%#{prefix}%")
  end
  
  def self.find_by_user(user)
    self.where(:user_id => user.id)
  end
  
  def self.find_items(list_id)
    TodoItem.where(:todo_list_id => list_id)
  end
  
end


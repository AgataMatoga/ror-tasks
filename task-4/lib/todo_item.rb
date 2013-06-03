require 'active_record'

class TodoItem < ActiveRecord::Base

  attr_accessible :title, :description, :list_id, :due_date

  belongs_to :todo_list

  validates :title, :list_id, :presence => true
  validates :title, :length => {:minimum => 1, :maximum => 30}
  validates :description, :length => {:maximum => 255}
  validates :due_date, :format => { :with => /\A\d{2}\/\d{2}\/\d{4}\z/ }
end


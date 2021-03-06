require 'active_record'


class TodoItem < ActiveRecord::Base
  
  attr_accessible :title, :description, :todo_list_id, :date_due_unchecked
  attr_accessor :date_due_unchecked
  belongs_to :todo_list

  validates :title, :todo_list_id, :presence => true
  validates :title, :length => {:minimum => 5, :maximum => 30}
  validates :description, :length => {:maximum => 255}
  validate :date_due_validation
  DATE_VALIDATION_RE = /[0-3][0-9]\/[0-1][0-9]\/[0-9]{2}(?:[0-9]{2})/

  def date_due_validation
    unless date_due_unchecked.match(DATE_VALIDATION_RE)
      errors.add(:date_due, 'date must be in dd/mm/yyyy format') 
    end
  end
  
  def self.find_by_list_id(list_id)
	where(:todo_list_id => list_id)
  end
  
  def self.find_by_too_long_description
	  where("LENGTH(description) > ?", 100)
  end
  
  def self.paginate(page)
    items = TodoItem.find_all_by_title
    offset = 5
    page -=1
    return items[offset*page..offset*page+(offset-1)]
  end
  
  def self.find_by_page(page)
	items = self.paginate
    return items[page]	
  end

  def self.find_by_user(user)  
    items ||= []
    TodoList.find_by_user(user).each do |list|
      self.find_by_list_id(list.id).each do |item|
        items << item
      end 
    end
    return items
  end
  
  def self.find_all_by_title
    find(:all, :order => "title ASC")
  end
  
  def self.find_by_word_in_description(word)
    searched_word = "%\s" + "#{word.downcase}" + "\s%"
    where("LOWER(description) LIKE ?", searched_word)
  end

  def self.find_by_user_and_date_due(user, date_due)
    self.find_by_user(user) & self.find_by_date_due(date_due)
  end

  def self.find_by_date_due(date_due)
    where("date_due == ?", date_due)
  end

  def self.find_by_due_year_and_month(year,month)
    where("date_due BETWEEN ? AND ?", Time.new(year, month), Time.new(year, month).end_of_month)
  end

  def self.find_overdue(date)
    where("date_due < ?", date)
  end
  
  def self.find_by_due_date_in_next_n_hours(date_from, hours)
    date_to = date_from + hours.hours
	where("date_due BETWEEN ? AND ?", date_from, date_to)
  end
  
  def self.find_by_due_week(year, week)
     date_from = Date.parse(Date.commercial(year,week, 1).to_s)
     date_to = Date.parse(Date.commercial(year, week,7 ).to_s)
	 where("date_due BETWEEN ? AND ?", date_from, date_to)
  end
  
  def self.find_beetwen_dates(date_from, date_to)
    where("date_due BETWEEN ? AND ?", date_from, date_to)
  end
  
end


class Book < ActiveRecord::Base
  has_many :reports

  validates_uniqueness_of   :title, :scope => :author
  validates_presence_of :title , :author

  def to_label
    "#{title} by #{author}"
  end

  def self.get_or_create_new_book(book_params)
    book =  Book.find(:first, :conditions => { :title => book_params[:title], :author => book_params[:author] })
    book ||= Book.new(book_params)
    book
  end

  def to_s
    "#{title}"
  end

end

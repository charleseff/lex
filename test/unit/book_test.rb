require File.dirname(__FILE__) + '/../test_helper'

class BookTest < Test::Unit::TestCase
  fixtures :books, :reports

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  # assert that multiple books can be found by search the same title:
  def test_multiple_books
    books = Book.find_all_by_title("Book 1")
    assert books.size == 2 
  end
  
  def test_get_specific_book_with_author_too
    book = Book.find(:first, :conditions => { :title => "Book 1", :author => "Author 1" })
    assert_not_nil book
    
    book2 = Book.find(:first, :conditions => { :title => "Book 1", :author => "no-one" })
    assert_nil book2
  end
  
  def test_get_or_create_new_book
    book = Book.get_or_create_new_book( {:title=> "Wheres Waldo", :author => "Goofy"})
    book.save
    assert_not_nil book
    
    waldo = Book.find_by_title("Wheres Waldo")
    assert_not_nil  waldo
    
  end

  def test_get_book_by_name
    book = books(:book_1)
    assert_equal book.title, 'Book 1'
  end


  def test_get_report_by_name
    report = reports(:bobby_report_graded_by_sean)
    assert_equal report.book.title, 'Book 2'
  end

end

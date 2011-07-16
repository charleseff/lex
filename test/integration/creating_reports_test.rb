require "#{File.dirname(__FILE__)}/../test_helper"
require "#{File.dirname(__FILE__)}/common_integration_test"

class CreatingReportsTest < ActionController::IntegrationTest
  include CommonIntegrationTest

  fixtures :users, :assignment_topics

  def test_create_failure
    login_as users(:bobby)

    # don't include author:
    multipart_post  'student_reports/create',
        :report => {:submitted_doc => fixture_file_upload( '../fixtures/Grapes_of_Wrath_by_Bobby.doc', 'application/msword')},
        :book => {:title => "Some Title"},
        :assignment_topic => {:id => assignment_topics(:four).id}

    assert_match  /Author can't be blank/, @response.body
  end

  def test_create_invalid_type
    login_as users(:bobby)
    title = "Some Title"
    author = "Some Author"

    multipart_post 'student_reports/create',
        :report => { :submitted_doc =>fixture_file_upload( '../fixtures/books.yml', 'text')},
        :book => {    :title => title,
            :author => author},
        :assignment_topic => {:id => assignment_topics(:four).id}


    assert_match  /Submitted document must be in microsoft word format/, @response.body
  end

  def test_create_success
    login_as users(:bobby)
    title = "Some Title"
    author = "Some Author"

    multipart_post_via_redirect  'student_reports/create',
        :report => { :submitted_doc => fixture_file_upload( '../fixtures/Grapes_of_Wrath_by_Bobby.doc', 'application/msword')},
        :book => {  :title => title,
            :author => author },
        :assignment_topic => {:id => assignment_topics(:four).id}

    # asserting that the window is doing a redirect
    assert_match  /window.location.href/, @response.body
  end

  def test_create_fails_on_preexisting_book
    login_as users(:bobby)
    book = books(:book_1)

    multipart_post  'student_reports/create',
        :report => {  :submitted_doc => fixture_file_upload( '../fixtures/Grapes_of_Wrath_by_Bobby.doc', 'application/msword')},
        :book => {:title => book.title,
            :author => book.author },
        :assignment_topic => {:id => assignment_topics(:four).id}

    assert_match  /Please do not re-submit/, @response.body
  end

  def test_create_fails_if_no_submitted_doc
    login_as users(:bobby)
    title = "Some Title"
    author = "Some Author"

    multipart_post_via_redirect  'student_reports/create',
        :report => { :submitted_doc => ''},
        :book => {  :title => title,
            :author => author },
        :assignment_topic => {:id => assignment_topics(:four).id}

    # asserting that the window is doing a redirect
    assert_match  /Submitted document must be in microsoft word format/, @response.body

  end


end

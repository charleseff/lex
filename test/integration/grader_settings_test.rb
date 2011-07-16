require "#{File.dirname(__FILE__)}/../test_helper"
require "#{File.dirname(__FILE__)}/common_integration_test"

class GraderSettingsTest < ActionController::IntegrationTest
  include CommonIntegrationTest

  fixtures :key_value_pairs, :users

  def setup
    super
    @emails     = ActionMailer::Base.deliveries
    @emails.clear

    @grader = users(:sean)
  end

  def test_ensure_grader_has_correct_grade_levels
    assert_equal(@grader.preferred_grade_levels, [GradeLevel.get_grade_level(1),GradeLevel.get_grade_level(3)])
  end

  def test_ensure_that_grader_preferred_grades_are_correct_in_account_settings
    login_as @grader
    get '/account/settings'
    assert_match /checked="checked".*Grade 3/, @response.body
    assert_match /checked="checked".*Grade 5/, @response.body

  end

  def test_ensure_that_when_grader_changes_preferred_grade_level_settings_they_show_up_correctly
    login_as @grader
    post '/account/settings', :current_user => { :preferred_grade_level_form_hash => [GradeLevel.american_to_lex_kim(3)] }

    assert_match /checked="checked".*Grade 3/, @response.body
    assert_no_match /checked="checked".*Grade 5/, @response.body
  end


end

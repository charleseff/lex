class EmailChangeRequest < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :confirmation_code
#  validates_uniqueness_of :user_id

  def before_validation_on_create
    self.confirmation_code = ApplicationController.random_string(20)
  end

end

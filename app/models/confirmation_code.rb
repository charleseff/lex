class ConfirmationCode < ActiveRecord::Base
  validates_presence_of :code
  belongs_to :user

  def before_validation_on_create
    self.code = ApplicationController.random_string(20)
  end

end

require File.dirname(__FILE__) + '/../spec_helper'

describe AccountController do

  it "should fail login and not redirect" do
    post :login, :email => 'quentin@example.com', :password => 'bad password'
    session[:user_id].should == nil
    response.should be_success
=begin
response.should redirect_to( :protocol => "https://", :controller=>'account', :action=>'login',
        :params => { :email => 'quentin@example.com', :password => 'bad password'})

=end
  end


end

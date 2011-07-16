ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  map.login 'login', :controller => 'account', :action => 'login'

  map.student_signup 'student_signup', :controller => 'account', :action => 'student_signup_auth'
  map.grader_signup 'grader_signup', :controller => 'account', :action => 'grader_signup_auth'

  # this screws shit up for some reason:
  #  map.show_grader_report 'grader_reports/:id', :controller => 'grader_reports', :action => 'show'
  #  map.show_student_report 'student_reports/:id', :controller => 'student_reports', :action => 'show'

  map.grader_resource_center 'grader/resource_center/:action/:id', :controller=>'resource_center/grader'
  map.student_resource_center 'student/resource_center/:action/:id', :controller=>'resource_center/student'

  map.student_show_flash 'student_reports/download_graded_flash/:id/show.swf', :controller=>'student_reports', :action=>'download_graded_flash'
  map.grader_show_flash 'grader_reports/download_graded_flash/:id/show.swf', :controller=>'grader_reports', :action=>'download_graded_flash'
  map.administrator_show_flash 'admin/reports/download_graded_flash/:id/show.swf', :controller=>'admin/reports', :action=>'download_graded_flash'

  map.show_student_report 'student/reports', :controller=>'student_reports'
  map.show_student_report 'grader/reports', :controller=>'grader_reports'

  map.show_student_report 'student/reports/:id', :controller=>'student_reports', :action=>'show'
  map.show_grader_report 'grader/reports/:id', :controller=>'grader_reports', :action=>'show'

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  # routes to the home controller: booyeah! finally got it to work..
  #  map.connect '/:action', :controller => 'home'

end

# Define a subclass of Ramaze::Controller holding your defaults for all controllers. Note 
# that these changes can be overwritten in sub controllers by simply calling the method 
# but with a different value.

class Controller < Ramaze::Controller
  helper :xhtml, :user
  layout :default
#  layout do |path|
#    if user.logged_in?
#      :loggedin
#    else
#      :default
#    end
#  end
  engine :etanni
end

private

def login_first
  return if logged_in?
  redirect MainController.r(:login)
end

# Here you can require all your other controllers. Note that if you have multiple
# controllers you might want to do something like the following:
#
#  Dir.glob('controller/*.rb').each do |controller|
#    require(controller)
#  end
#
require __DIR__('main')

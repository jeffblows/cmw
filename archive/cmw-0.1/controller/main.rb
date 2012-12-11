# Default url mappings are:
# 
# * a controller called Main is mapped on the root of the site: /
# * a controller called Something is mapped on: /something
# 
# If you want to override this, add a line like this inside the class:
#
#  map '/otherurl'
#
# this will force the controller to be mounted on: /otherurl.
class MainController < Controller
  # the index action is called automatically when no other action is specified
  def index
    @title = 'Welcome to Ramaze!'
  end

  def login
    @title = "Login"
    redirect_referer if logged_in?
    return unless request.post?
    if user_login(request.subset(:login, :password))
      flash[:success] = 'Logged in'
      redirect MainController.r(:index)
    else
      flash[:error] = 'Username or Password incorrect'
    end
  end

  def register
    @title = "Register for an account"
    @user = nil
  end

  def save

    if request.post?
      @user = flash[:form_data] || User.new
      @user[:email] = request[:email]
      @user[:login] = request[:email]
      @user.password = request[:password]
      @user.password_confirmation = request[:password_confirmation]
      @user.password_salt = Digest::SHA1.hexdigest("--#{Time.now.to_f}--#{user.email}--")

      if @user.valid?   # sequel model validation
        if @user.save
          flash[:success] = 'Account created, feel free to login below'
          redirect MainController.r(:login)
        end
      else
        if (@user.errors.on(:email) or @user.errors.on(:login)) != nil
          @user[:email] = nil
          @user[:login] = nil
          flash[:error] = 'An account already exists with that user name'
        end
        if @user.errors.on(:password_confirmation) != nil
          @user.password = nil
          @user.password_confirmation = nil
          flash[:error] = 'Password and confirmation do not match'
        end
        @title = "Fix Errors"
        render_view(:register)
#        redirect MainController.r(:register)
      end
    end
  end

  def logout
    flash[:success] = "Logged out"
    user_logout
    redirect MainController.r(:index)
  end

  # the string returned at the end of the function is used as the html body
  # if there is no template for the action. if there is a template, the string
  # is silently ignored
  def notemplate
    @title = 'Welcome to Ramaze!'
    
    return 'There is no \'notemplate.xhtml\' associated with this action.'
  end
end

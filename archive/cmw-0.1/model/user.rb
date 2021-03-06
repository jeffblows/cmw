class User < Sequel::Model(:users)
  plugin :validation_helpers
  def validate
    super
    validates_unique :email, :login
    validates_equal(:password, :password_confirmation)
  end

  attr_accessor :password
  attr_accessor :password_confirmation

  def after_create
    self.crypted_password = encrypt(password)
    @new = false
    save
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def encrypt(password)
    self.class.encrypt(password, password_salt)
  end

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  def self.authenticate(hash)
    email, pass = hash['login'], hash['password']

    if user = User[:email => email]
      return user unless pass
      user if user.authenticated?(pass)
    end
  end

end


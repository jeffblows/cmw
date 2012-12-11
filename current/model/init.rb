# This file is used for loading all your models. Note that you don't have to actually use
# this file. The great thing about Ramaze is that you're free to change it the way you see
# fit.

class Sequel::Model
  def validates_equal(c1, c2)
    errors.add(c2, "must equal #{c1}") if send(c1) != send(c2)
  end
end

# Here go your requires for models:
require __DIR__('user')

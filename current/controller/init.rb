# Define a subclass of Ramaze::Controller holding your defaults for all controllers. Note 
# that these changes can be overwritten in sub controllers by simply calling the method 
# but with a different value.

class Controller < Ramaze::Controller
  helper :xhtml, :user, :blue_form
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

# Represents a C# style enumeration of known values.
#
# Usage:
#   Color = Enum.new(:Red, :Green, :Blue)
#   Color.is_a?(Enum) # => true
#   Color::Red.inspect # => "Color::Red"
#   Color::Green.is_a?(Color) # => true
#   Color::Green.is_a?(Enum::Member) # => true
#   Color::Green.index # => 1
#   Color::Blue.enum # => Color
#   values = [[255, 0, 0], [0, 255, 0], [0, 0, 255]]
#   values[Color::Green] # => [0, 255, 0]
#   Color[0] # => Color::Red
#   Color.size # => 3
#
# Enums are enumerable. Enum::Members are comparable.
class Enum < Module
  class Member < Module
    attr_reader :enum, :index

    def initialize(enum, index)
      @enum, @index = enum, index
      # Allow Color::Red.is_a?(Color)
      extend enum
    end

    # Allow use of enum members as array indices
    alias :to_int :index
    alias :to_i :index

    # Allow comparison by index
    def <=>(other)
      @index <=> other.index
    end

    include Comparable
  end

  def initialize(*symbols, &block)
    @members = []
    symbols.each_with_index do |symbol, index|
      # Allow Enum.new(:foo)
      symbol = symbol.to_s.sub(/^[a-z]/) { |letter| letter.upcase }.to_sym
      member = Enum::Member.new(self, index)
      const_set(symbol, member)
      @members << member
    end
    super(&block)
  end

  def [](index) @members[index] end
  def size() @members.size end
  alias :length :size

  def first(*args) @members.first(*args) end
  def last(*args) @members.last(*args) end

  def each(&block) @members.each(&block) end
  include Enumerable
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
require __DIR__('ourclub')

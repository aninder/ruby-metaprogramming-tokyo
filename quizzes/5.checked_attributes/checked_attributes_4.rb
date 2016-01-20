# Transform add_checked_attribute() so that it becomes a Class Macro for any class,
# named attr_checked(). Look at the definition of the Person class for an example.

# This quiz should be relatively easy if you solved the previous quiz. You just need
# to take the code from the previous quiz, and put it in the Class class. As usual,
# ask the teachers if you're stuck.

class Class
  def attr_checked(attr, &b)
   define_method attr do
     instance_variable_get("@#{attr}")
   end
   define_method "#{attr}=" do |aa|
     raise "Invalid attribute" unless b.call(aa)
     instance_variable_set("@#{attr}",aa)
   end
  end
end

require 'test/unit'

class Person
  attr_checked :age do |v|
    v >= 18
  end
end

class TestCheckedAttributes < Test::Unit::TestCase
  def setup
    @bob = Person.new
  end

  def test_accepts_valid_values
    @bob.age = 20
    assert_equal 20, @bob.age
  end

  def test_refuses_invalid_values
    assert_raises RuntimeError.new('Invalid attribute') do
      @bob.age = 17
    end
  end
end

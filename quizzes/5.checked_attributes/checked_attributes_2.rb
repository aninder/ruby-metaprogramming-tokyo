# Once again, fill in the code in the add_checked_attribute() method. This time,
# don't use strings of code and eval(). Instead, write standard Ruby code to
# define the reader and the writer methods. The test is the same as the previous
# quiz (checked_attributes_1.rb).

# This is a hard quiz! Whenever you feel a bit stuck, your teachers are there to
# help you. Good luck!

def add_checked_attribute(klass, attribute)
  klass.class_eval do
    define_method "#{attribute}" do
      instance_variable_get("@#{attribute}");
    end
    define_method "#{attribute}=" do |attr|
      raise RuntimeError.new('Invalid attribute') if !attr
      instance_variable_set("@#{attribute}", attr)
    end
  end
end
  # fill in this code!

  require 'test/unit'

  class Person; end

  class TestCheckedAttribute < Test::Unit::TestCase
    def setup
      add_checked_attribute(Person, :age)
      @bob = Person.new
    end

    def test_accepts_valid_values
      @bob.age = 20
      assert_equal 20, @bob.age
    end

    def test_refuses_nil_values
      assert_raises RuntimeError.new('Invalid attribute') do
        @bob.age = nil
      end
    end

    def test_refuses_false_values
      assert_raises RuntimeError.new('Invalid attribute') do
        @bob.age = false
      end
    end
  end

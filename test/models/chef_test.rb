require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Joe Cook", email: "jcook@ebaraintl.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname not too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "chefname not too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should be unique" do
    chef2 = @chef.dup
    chef2.email = @chef.email.upcase
    @chef.save
    assert_not chef2.valid?
  end

  test "email validation accept" do
    valid_addresses = %w[user@ccc.com R_TDD-D5@CCC.com user@example.com first.last@ccc.eu laura-joe@monk.com]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

end
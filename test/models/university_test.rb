require 'test_helper'

class UniversityTest < ActiveSupport::TestCase
  test "valid name" do
    univ = University.new

    univ.name = "Giuerh"
    assert univ.save
  end

  test "valid name not present" do
    univ = University.new

    assert_not univ.save
  end

end

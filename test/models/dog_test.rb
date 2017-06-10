require 'test_helper'

class DogTest < ActiveSupport::TestCase
  setup do
    @data = {
      :name => 'Dog',
      :breed => BREEDS[0],
      :genre => 'male',
      :castrated => false,
      :birth => '10/10/2010',
      :owner_name => 'Owner Name',
      :owner_phone => '(999) 999-9999',
      :last_visit => '01/03/2017'
    }
  end

  test "valid dog" do
    dog = Dog.new(@data)

    assert dog.valid?
  end

  test "invalid dog without name" do
    dog = Dog.new(@data.slice!(:name))

    refute dog.valid?
    assert_not_nil dog.errors[:name]
    assert_equal dog.errors[:name], ['can\'t be blank']
  end

  test "invalid dog without breed" do
    dog = Dog.new(@data.slice!(:breed))

    refute dog.valid?
    assert_not_nil dog.errors[:breed]
    assert_equal dog.errors[:breed], ['can\'t be blank']
  end

  test "invalid dog without genre" do
    dog = Dog.new(@data.slice!(:genre))

    refute dog.valid?
    assert_not_nil dog.errors[:genre]
    assert_equal dog.errors[:genre], ['can\'t be blank']
  end

  test "invalid dog without castrated" do
    dog = Dog.new(@data.slice!(:castrated))

    refute dog.valid?
    assert_not_nil dog.errors[:castrated]
    assert_equal dog.errors[:castrated], ['is not included in the list']
  end

  test "invalid dog without birth" do
    dog = Dog.new(@data.slice!(:birth))

    refute dog.valid?
    assert_not_nil dog.errors[:birth]
    assert_equal dog.errors[:birth], ['can\'t be blank']
  end

  test "invalid dog without owner_name" do
    dog = Dog.new(@data.slice!(:owner_name))

    refute dog.valid?
    assert_not_nil dog.errors[:owner_name]
    assert_equal dog.errors[:owner_name], ['can\'t be blank']
  end

  test "invalid dog without owner_phone" do
    dog = Dog.new(@data.slice!(:owner_phone))

    refute dog.valid?
    assert_not_nil dog.errors[:owner_phone]
    assert_equal dog.errors[:owner_phone], ['can\'t be blank']
  end

  test "invalid dog without last_visit" do
    dog = Dog.new(@data.slice!(:last_visit))

    refute dog.valid?
    assert_not_nil dog.errors[:last_visit]
    assert_equal dog.errors[:last_visit], ['can\'t be blank']
  end

end

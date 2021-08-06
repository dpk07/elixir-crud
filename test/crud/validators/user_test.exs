defmodule Crud.Validator.UserTest do
  use ExUnit.Case
  alias Crud.Entity.User
  alias Crud.Validator.User, as: UserValidator
  describe "User.valid?/1" do
    test "Should return false if any field is nil" do
      user = %User{username: "Abc", first_name: "abc"}
      assert UserValidator.valid?(user) == false
    end

    test "Should return false if all fields are present and age is less than equal to zero" do
      user = %User{username: "Abc", first_name: "abc", last_name: "abc", id: "abc", age: 0}
      assert UserValidator.valid?(user) == false
    end

    test "Should return true if all fields are present and age is greater than zero" do
      user = %User{username: "Abc", first_name: "abc", last_name: "abc", age: 18}
      assert UserValidator.valid?(user) == true
    end
  end
end

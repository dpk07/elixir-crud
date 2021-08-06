defmodule Crud.Entity.UserTest do
  use ExUnit.Case
  alias Crud.Entity.User


  describe "User.new/1" do
    test "Should create new user properly and return ok with new user" do
      params = %{first_name: "Deepak", last_name: "Pai", username: "deepakpai", age: 18}
      assert User.new(params) == {:ok, %User{first_name: "Deepak", last_name: "Pai", username: "deepakpai", age: 18}}
    end

    test "Should return invalid if details are invalid" do
      params = %{first_name: "Deepak", last_name: "Pai", age: 18}
      assert User.new(params) == {:error, :invalid}
    end
  end

  describe "User.update/1" do
    test "Should update user with allowed parameters" do
      user = %User{first_name: "Deepak", last_name: "Pai", username: "deepakpai", age: 18}
      params = %{first_name: "Deep", last_name: "Bezos", age: 20}
      assert User.update(user, params) == {:ok, %User{first_name: "Deep", last_name: "Bezos", username: "deepakpai", age: 20}}
    end

    test "Should not update if parameters are allowed but invalid" do
      user = %User{first_name: "Deepak", last_name: "Pai", username: "deepakpai", age: 18}
      params = %{first_name: "Deep", last_name: "Bezos", age: 0}
      assert User.update(user, params) == {:error, :invalid}
    end

    test "Should not update user with dis-allowed parameters" do
      user = %User{first_name: "Deepak", last_name: "Pai", username: "deepakpai", age: 18}
      params = %{id: 2}
      assert User.update(user, params) == {:ok, %User{first_name: "Deepak", last_name: "Pai", username: "deepakpai", age: 18}}
    end
  end
end

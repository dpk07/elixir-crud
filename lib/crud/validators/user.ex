defmodule Crud.Validator.User do
  @fields  ~w"username first_name last_name age"a

  def valid?(user) do
    not Enum.any?(@fields, &is_nil(Map.get(user, &1))) and user.age > 0
  end
end

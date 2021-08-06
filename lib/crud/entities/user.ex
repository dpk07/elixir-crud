defmodule Crud.Entity.User do
  @derive {Jason.Encoder, only: [:id, :username, :first_name, :last_name, :age]}
  defstruct [:id, :username, :first_name, :last_name, :age]

  alias Crud.Entity.User
  alias Crud.Validator.User, as: UserValidator

  @allowed_update_fields ~w"first_name last_name age"a

  def new(params) do
    user = struct!(User, params)
    case UserValidator.valid?(user) do
      true -> {:ok, user}
      false -> {:error, :invalid}
    end
  end

  def update(user, params) do
    user = Enum.reduce(@allowed_update_fields, user,fn field, user ->
      case Map.has_key?(params, field) do
        true -> Map.put(user, field, Map.get(params, field))
        false -> user
      end
    end)

    case UserValidator.valid?(user) do
      true -> {:ok, user}
      false -> {:error, :invalid}
    end
  end
end

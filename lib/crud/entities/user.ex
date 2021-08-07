defmodule Crud.Entity.User do
  # @derive {Jason.Encoder, only: [:id, :username, :first_name, :last_name, :age]}
  # defstruct [:id, :username, :first_name, :last_name, :age]

  alias Crud.Entity.User
  alias Crud.Models.User

  def new(params) do
    changeset = User.create_changeset(%User{}, params)

    case changeset.valid? do
      true -> {:ok, changeset}
      false -> {:error, :invalid}
    end
  end

  def update(user, params) do
    changeset = User.create_changeset(user, params)

    case changeset.valid? do
      true -> {:ok, changeset}
      false -> {:error, :invalid}
    end
  end
end

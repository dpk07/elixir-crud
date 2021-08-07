defmodule Crud.Models.User do
  use Ecto.Schema

  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :username, :first_name, :last_name, :age]}
  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :age, :integer

    timestamps()
  end

  def create_changeset(user, params) do
    fields = ~w"username first_name last_name age"a

    user
    |> cast(params, fields)
    |> changeset()
  end

  def update_changeset(user, params) do
    fields = ~w"first_name last_name age"a

    user
    |> cast(params, fields)
    |> changeset()
  end

  defp changeset(changeset) do
    required_fields = ~w"username first_name last_name age"a

    changeset
    |> validate_required(required_fields)
    |> validate_inclusion(:age, 18..100)
    |> unique_constraint(:username, message: "already used.")
  end
end

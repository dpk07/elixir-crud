defmodule Crud.Repository.UserRepo do
  alias Crud.Repo
  alias Crud.Models.User
  import Ecto.Changeset
  def create(user) do
    case Repo.insert(user) do
      {:ok, user} -> user
      {:error, changeset} -> traverse_errors(changeset)
    end
  end

  def get(id) do
    Repo.get(User, id)
  end

  def update(user) do
    case Repo.update(user) do
      {:ok, user} -> user
      {:error, changeset} -> traverse_errors(changeset)
    end
  end

  def delete(id) do
    user = Repo.get(User, id)
    case Repo.delete(user) do
      {:ok, user} -> user
      {:error, changeset} -> traverse_errors(changeset)
    end
  end

  def all() do
    Repo.all(User)
  end

  def traverse_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end

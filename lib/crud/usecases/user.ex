defmodule Crud.Usecase.User do
  alias Crud.Entity.User
  alias Crud.Repository.UserRepo
  def create(params) do
    case User.new(params) do
      {:ok, user} -> {:ok, UserRepo.create(user)}
      {:error, :invalid} -> invalid_params()
    end
  end

  def get(id) do
    {:ok, UserRepo.get(id)}
  end

  def update(params) do
    with user when not is_nil(user) <- UserRepo.get(params.id),
    {:ok, updated_user} <- User.update(user, params) do
      {:ok, UserRepo.update(updated_user)}
    else
      nil -> {:not_found, "User not found"}
      {:error, :invalid} -> invalid_params()
    end
  end

  def delete(id) do
    {:ok, UserRepo.delete(id)}
  end

  def all() do
    {:ok, UserRepo.all()}
  end

  defp invalid_params(), do: {:error, "Invalid parameters"}
end

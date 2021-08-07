defmodule Crud.Repository.InMemoryUserRepo do
  alias Crud.Server.UserDb
  def create(user) do
    UserDb.create(user)
  end

  def get(id) do
    UserDb.get(id)
  end

  def update(user) do
    IO.inspect user
    UserDb.update(user)
  end

  def delete(id) do
    UserDb.delete(id)
  end

  def all() do
    UserDb.all()
  end
end

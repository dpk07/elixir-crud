defmodule CrudWeb.UserController do
  use CrudWeb, :controller

  import CrudWeb.Helper

  alias Crud.Usecase.User

  def create(conn, %{"username" => username, "first_name" => first_name, "last_name" => last_name, "age" => age}) do
    params = %{
      first_name: first_name,
      last_name: last_name,
      age: age,
      username: username
    }
    User.create(params) |> respond(conn)
  end

  def update(conn, %{"first_name" => first_name, "last_name" => last_name, "age" => age, "id" => id}) do
    params = %{
      first_name: first_name,
      last_name: last_name,
      age: age,
      id: id
    }
    User.update(params) |> respond(conn)
  end

  def get(conn, %{"id" => id}) do
    User.get(String.to_integer(id)) |> respond(conn)
  end

  def delete(conn, %{"id" => id}) do
    User.delete(String.to_integer(id)) |> respond(conn)
  end

  def all(conn, _params) do
    User.all() |> respond(conn)
  end
end

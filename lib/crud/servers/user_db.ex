defmodule Crud.Server.UserDb do
  use GenServer

  # Client

  def start_link(_default) do
    GenServer.start_link(__MODULE__, get_initial_state(), name: __MODULE__)
  end

  def create(user) do
    GenServer.call(__MODULE__, {:create, user})
  end

  def update(user) do
    GenServer.call(__MODULE__, {:update, user})
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def delete(id) do
    GenServer.call(__MODULE__, {:delete, id})
  end

  def all() do
    GenServer.call(__MODULE__, :all)
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:create, user}, _, %{users: users_map, last_id: last_id, usernames: usernames} = state) do
    if MapSet.member?(usernames, user.username) do
      {:reply, "Username already taken.", state}
    else
      new_usernames = MapSet.put(usernames, user.username)
      new_id = last_id + 1
      user = Map.put(user, :id, new_id)
      users_map = Map.put(users_map, new_id, user)
      {:reply, user, %{users: users_map, last_id: new_id, usernames: new_usernames}}
    end
  end

  @impl true
  def handle_call({:update, user}, _, %{users: users_map, last_id: last_id}) do
    users_map = Map.put(users_map, user.id, user)
    {:reply, user, %{users: users_map, last_id: last_id}}
  end

  @impl true
  def handle_call({:delete, id}, _, %{users: users_map, last_id: last_id}) do
    users_map = Map.delete(users_map, id)
    {:reply, nil, %{users: users_map, last_id: last_id}}
  end

  @impl true
  def handle_call({:get, id}, _, %{users: users_map, last_id: last_id}) do
    IO.inspect id
    user = Map.get(users_map, id) |> IO.inspect
    {:reply, user, %{users: users_map, last_id: last_id}}
  end

  @impl true
  def handle_call(:all, _nothing, %{users: users_map, last_id: last_id}) do
    users = Map.values(users_map)
    {:reply, users, %{users: users_map, last_id: last_id}}
  end

  defp get_initial_state(), do: %{users: %{}, last_id: 0, usernames: MapSet.new()}
end

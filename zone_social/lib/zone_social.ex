defmodule ZoneSocial do
  @moduledoc """
  Documentation for `ZoneSocial`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ZoneSocial.hello()
      :world

  """
  def hello do
    :world
  end

  def conec(db) do
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27027/#{db}", username: "root", password: "pass", auth_source: "admin")
    conn
  end

  def insert_user(conn, nombre, usuario) do
    data = %{name: nombre, user: usuario}
    result = Mongo.insert_one!(conn, "user", data)
    Map.put(data, :id, result.inserted_id)
  end

  def insert_post(conn, mensaje, usuario) do
    data = %{post: mensaje, user: usuario}
    result = Mongo.insert_one!(conn, "post", data)
    Map.put(data, :id, result.inserted_id)
  end

  def consulta_users(conn) do
    result = Mongo.find(conn, "user", %{})
    result |> Enum.to_list() |> IO.inspect
  end

  def consulta_friend(conn, name) do
    result = Mongo.find(conn, "user", %{"friend.name": name})
    result |> Enum.to_list() |> IO.inspect
  end

  def consulta_post(conn) do
    result = Mongo.find(conn, "post", %{})
    result |> Enum.to_list() |> IO.inspect
  end

  # def buscamigo(amigo) do

  # end


end

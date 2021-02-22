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

  def insert_user(data) do
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27027/zone-social", username: "root", password: "pass", auth_source: "admin")
    result = Mongo.insert_one!(conn, "user", data)
    Map.put(data, :id, result.inserted_id)
  end

  def consulta_user() do
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27027/zone-social", username: "root", password: "pass", auth_source: "admin")
    result = Mongo.find(conn, "user", %{})
    result |> Enum.to_list() |> IO.inspect
  end

  def consulta_post() do
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27027/zone-social", username: "root", password: "pass", auth_source: "admin")
    result = Mongo.find(conn, "post", %{})
    result |> Enum.to_list() |> IO.inspect
  end

  # def buscamigo(amigo) do

  # end


end

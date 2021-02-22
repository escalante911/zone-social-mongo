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

  def insertOne(conn, coll, data) do
    result = Mongo.insert_one!(conn, coll, data)
    Map.put(data, :id, result.inserted_id)
  end

  def consulta(conn, coll) do
    result = Mongo.find(conn, coll, %{})
    result |> Enum.to_list() |> IO.inspect
  end


end

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


  # def buscamigo(amigo) do

  # end


end

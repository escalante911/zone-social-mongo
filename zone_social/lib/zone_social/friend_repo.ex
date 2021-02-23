defmodule FriendRepo do

def conec(db) do
  {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27027/#{db}", username: "root", password: "pass", auth_source: "admin")
  conn
end

# Consulta los amigos de un usuario
def consulta_friend(conn, nombre) do
  result = Mongo.find(conn, "user", %{"name": nombre})
  result |> Enum.to_list() |> IO.inspect
end

def update_user(conn, nombre, usuario) do
  data = %{name: nombre}
  actu = %{"$set": %{user: usuario}}
  Mongo.update_one!(conn, "user", data, actu)
  # Map.put(data, :id, result.inserted_id)
end

def add_friend(conn, user, friend) do
  result = Mongo.find(conn, "user", %{"name": friend})
  result |> Enum.to_list() |> IO.inspect
  data = %{name: user}
  actu = %{"$addToSet": %{friend: result}}
  Mongo.update_one!(conn, "user", data, actu)
  # Map.put(:ok, result._id, "Listo")
end

end

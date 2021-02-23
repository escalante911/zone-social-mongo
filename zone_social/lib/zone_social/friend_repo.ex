defmodule FriendRepo do

# Se ejecuta una sola vez al incicio de los procesos guardando el retorno en una variable conn
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

# Consulto el usuario y el amigo
# lo guardo en una variable y luego saco el mapa de alli [x] = x
# extraigo el id y = x["_id"]
# le envio al modulo la conexión, el usuario y el id del amigo (conn, user, friend, n, y)
def add_friend(conn, user, friend, id_user, id_friend) do
  data = %{name: user}
  data2 = %{name: friend}
  actu = %{"$addToSet": %{friend: id_friend}}
  actu2 = %{"$addToSet": %{friend: id_user}}
  Mongo.update_one!(conn, "user", data, actu)
  Mongo.update_one!(conn, "user", data2, actu2)
end

end

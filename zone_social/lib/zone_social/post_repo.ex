defmodule PostRepo do

# Se ejecuta una sola vez al incicio de los procesos guardando el retorno en una variable conn
def conec(db) do
  {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27027/#{db}", username: "root", password: "pass", auth_source: "admin")
  conn
end

# Consulto el usuario
# lo guardo en una variable y luego saco el mapa de allí [x] = x
# extraigo el id y = x["_id"]
# le envio al modulo la conexión, el mensaje y el usuario (conn, mensaje, usuario)
# Inserta un post a la base de datos
def insert_post(conn, mensaje, usuario) do
  data = %{post: mensaje, user: usuario}
  result = Mongo.insert_one!(conn, "post", data)
  Map.put(data, :id, result.inserted_id)
end

# Consulta todos los post
def consulta_post(conn) do
  result = Mongo.find(conn, "post", %{})
  result |> Enum.to_list() |> IO.inspect
end

# Consulta todos los post
def consul_post_limit(conn, limit) do
  result = Mongo.find(conn, "post", %{}, limit: limit)
  result |> Enum.to_list() |> IO.inspect
end

def poster(conn, friends) when is_list(friends) and length(friends) > 1, do: posterp(conn, hd(friends), tl(friends), [])
defp posterp(conn, friend, [], new), do: new ++ busca_post(conn, friend)
defp porterp(conn, friend, [h | t], new), do: posterp(conn, h, t, new ++ busca_post(conn, friend))

def busca_post(conn, user) do
  result = Mongo.find(conn, "post", %{"user": user})
  result |> Enum.to_list() |> IO.inspect
end

end

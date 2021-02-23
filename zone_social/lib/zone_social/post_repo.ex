defmodule PostRepo do

def conec(db) do
  {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27027/#{db}", username: "root", password: "pass", auth_source: "admin")
  conn
end

# Consulto el usuario
# lo guardo en una variable y luego saco el mapa de alli [x] = x
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

end

defmodule UserRepo do

# Se ejecuta una sola vez al incicio de los procesos guardando el retorno en una variable conn
def conec(db) do
  {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27027/#{db}", username: "root", password: "pass", auth_source: "admin")
  conn
end

# Inserta un usuario a la base de datos
def insert_user(conn, nombre, usuario) do
  data = %{name: nombre, user: usuario}
  result = Mongo.insert_one!(conn, "user", data)
  Map.put(data, :id, result.inserted_id)
end

# Consulta todos los usuarios de la base de datos
def consulta_users(conn) do
  result = Mongo.find(conn, "user", %{})
  result |> Enum.to_list() |> IO.inspect
end

end

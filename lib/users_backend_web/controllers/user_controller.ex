defmodule UsersBackendWeb.UserController do
  use UsersBackendWeb, :controller

  alias UsersBackend.Users
  alias UsersBackend.Users.Projections.User

  action_fallback UsersBackendWeb.FallbackController


  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with  {:ok, attrs} <- User.validate_params_register(user_params),
          {:ok, %User{} = user} <- Users.create_user(attrs) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn,  %{"email" => email, "password" => password})do
    case  UsersBackend.Guardian.authenticate( email, password) do
      {:ok, user, token} -> render(conn, :show_sign_in, %{user: user,  token: token})

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> put_view( json: UsersBackendWeb.ErrorJSON)
        |> render(:"403", error: "invalid credentials")
    end

  end



  def me(conn, _params) do
    user = UsersBackend.Guardian.Plug.current_resource(conn)
    conn |> put_status(200) |> json(%{email: user.email, id: user.uuid})
  end

  def register_favorite_color(conn, %{ "user" => user_params}) do
    resource_user = UsersBackend.Guardian.Plug.current_resource(conn)
    user = Users.get_user!(resource_user.uuid)

    with  {:ok, _attrs} <- User.validate_params_register_favorite_color(user_params),
          {:ok, %User{} = user} <- Users.update_favorite_color(user, user_params) do
      render(conn, :show, user: user)
    end
  end

end

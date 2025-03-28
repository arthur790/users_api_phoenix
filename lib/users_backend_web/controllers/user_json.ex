defmodule UsersBackendWeb.UserJSON do
  alias UsersBackend.Users.Projections.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end
  def show_sign_in(%{user: user,  token: token}) do
    %{data: data(user, token)}
  end

  defp data(%User{} = user) do
    %{
      id: user.uuid,
      name: user.name,
      email: user.email,
      color: user.favorite_color
    }
  end

  defp data(%User{} = user, token) do
    %{
      id: user.uuid,
      email: user.email,
      token: token
    }
  end
end

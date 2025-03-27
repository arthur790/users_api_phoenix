defmodule UsersBackendWeb.AccountTokenJSON do
  alias UsersBackend.Users.Projections.User

  def render("account_token.json", %{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end

end

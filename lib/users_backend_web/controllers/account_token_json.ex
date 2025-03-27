defmodule UsersBackendWeb.AccountTokenJSON do
  alias UsersBackend.Users.Projections.User

  def render("account_token.json", %{account: account, token: token}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end

end

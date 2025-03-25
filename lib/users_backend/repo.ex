defmodule UsersBackend.Repo do
  use Ecto.Repo,
    otp_app: :users_backend,
    adapter: Ecto.Adapters.Postgres
end

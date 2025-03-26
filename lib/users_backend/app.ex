defmodule UsersBackend.App do
  use Commanded.Application, otp_app: :users_backend

  router(UsersBackend.Router)
end

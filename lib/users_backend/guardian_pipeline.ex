defmodule UsersBackend.GuardianPipeline do

  use Guardian.Plug.Pipeline,
    otp_app: :users_backend,
    module: UsersBackend.Guardian,
    error_handler: UsersBackend.GuardianErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource

end

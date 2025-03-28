defmodule UsersBackend.Users.Events.SignedIn do
  @derive Jason.Encoder
  defstruct [
    :user_id,
    :jwt
  ]
end

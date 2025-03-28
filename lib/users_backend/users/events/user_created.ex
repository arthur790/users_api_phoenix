defmodule UsersBackend.Users.Events.UserCreated do
  @derive Jason.Encoder
  defstruct [
    :uuid,
    :name,
    :password,
    :email,
    :confirm_password
  ]
end

defmodule UsersBackend.Users.Events.FavoriteColorRegistered do
  @derive Jason.Encoder
  defstruct [
    :uuid,
    :favorite_color
  ]
end

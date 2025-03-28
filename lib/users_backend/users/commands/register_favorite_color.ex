defmodule UsersBackend.Users.Commands.RegisterFavoriteColor do

  defstruct [
    :uuid,
    :favorite_color
  ]

  use ExConstructor
  alias UsersBackend.Users.Commands.RegisterFavoriteColor

  def assign_uuid(%RegisterFavoriteColor{} = register_favorite_color, uuid) do
    %RegisterFavoriteColor{register_favorite_color | uuid: uuid}
  end

end

defmodule UsersBackend.Users.Commands.UpdateUser do
  defstruct [
    :uuid,
    :name,
    :password,
    :email,
    :favorite_color
  ]

  use ExConstructor
  alias UsersBackend.Users.Commands.UpdateUser

  def assign_uuid(%UpdateUser{} = update_user, uuid) do
    %UpdateUser{update_user | uuid: uuid}
  end
end

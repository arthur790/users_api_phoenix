defmodule UsersBackend.Users.Commands.CreateUser do
  defstruct [
    :uuid,
    :name,
    :password,
    :email
  ]

  use ExConstructor

  alias UsersBackend.Users.Commands.CreateUser

  def assign_uuid(%CreateUser{} = create_user, uuid) do
    %CreateUser{create_user | uuid: uuid}
  end

end

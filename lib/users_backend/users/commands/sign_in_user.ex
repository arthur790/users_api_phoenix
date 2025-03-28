defmodule UsersBackend.Users.Commands.SignInUser do
  defstruct [
    :user_id,
    :jwt
  ]


  use ExConstructor
  alias UsersBackend.Users.Commands.SignInUser

  def assign_uuid(%SignInUser{} = sign_in_user, uuid) do
    %SignInUser{sign_in_user | user_id: uuid}
  end


end

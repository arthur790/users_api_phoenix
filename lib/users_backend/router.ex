defmodule UsersBackend.Router do

  use Commanded.Commands.Router

  alias UsersBackend.Users.Aggregates.User
  alias UsersBackend.Users.Commands.{CreateUser, UpdateUser}


  dispatch([CreateUser,UpdateUser],
    to: User,
    identity: :uuid,
    lifespan: User
  )

end

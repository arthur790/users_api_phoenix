defmodule UsersBackend.Router do

  use Commanded.Commands.Router

  alias UsersBackend.Users.Aggregates.User
  alias UsersBackend.Users.Commands.{CreateUser}


  dispatch([CreateUser],
    to: User,
    identity: :uuid,
    lifespan: User
  )

end

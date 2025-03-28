defmodule UsersBackend.Router do

  use Commanded.Commands.Router

  alias UsersBackend.Users.Aggregates.User
  alias UsersBackend.Users.Commands.{CreateUser, UpdateUser, RegisterFavoriteColor}


  dispatch([CreateUser,UpdateUser,RegisterFavoriteColor],
    to: User,
    identity: :uuid,
    lifespan: User
  )

end

defmodule UsersBackend.Users.Projectors.User do
  use Commanded.Projections.Ecto,
    application: UsersBackend.App,
    repo: UsersBackend.Repo,
    name: "Users.Projectors.User",
    consistency: :strong

  alias UsersBackend.Users.Aggregates.User
  #alias UsersBackend.Repo
  alias UsersBackend.Users.Events.{UserCreated}

  alias UsersBackend.Users.Projections.User


  project(%UserCreated{} = created, _, fn multi ->
    Ecto.Multi.insert(multi, :todo, %User{
      uuid: created.uuid,
      name: created.name,
      password: created.password,
      email: created.email
    })
  end)
end

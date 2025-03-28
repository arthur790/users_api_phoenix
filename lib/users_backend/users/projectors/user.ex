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
    Ecto.Multi.insert(multi, :todo, User.changeset(%User{}, %{
      uuid: created.uuid,
      name: created.name,
      password: created.password,
      email: created.email

    },
    password_confirmation: created.confirm_password

    ))
  end)
end

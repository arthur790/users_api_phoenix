defmodule UsersBackend.Users.Projectors.User do
  use Commanded.Projections.Ecto,
    application: UsersBackend.App,
    repo: UsersBackend.Repo,
    name: "Users.Projectors.User",
    consistency: :strong

  alias UsersBackend.Users.Aggregates.User
  alias UsersBackend.Repo
  alias UsersBackend.Users.Events.{UserCreated, FavoriteColorRegistered}

  alias UsersBackend.Users.Projections.User


  project(%UserCreated{} = created, _, fn multi ->
    Ecto.Multi.insert(multi, :todo, User.changeset(%User{}, %{
      uuid: created.uuid,
      name: created.name,
      password: created.password,
      email: created.email,
      password_confirmation: created.password_confirmation

    }

    ))
  end)


  project(%FavoriteColorRegistered{uuid: uuid, favorite_color: favorite_color}, _, fn multi ->
    case Repo.get(User, uuid) do
      nil -> multi
      user -> Ecto.Multi.update(multi, :user, User.update_changeset(user, %{favorite_color: favorite_color}))
    end
  end)
end

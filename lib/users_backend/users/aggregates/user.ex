defmodule UsersBackend.Users.Aggregates.User do

  defstruct [
    :uuid,
    :name,
    :password,
    :email,
    :favorite_color,
    :jwt
  ]


  @behaviour Commanded.Aggregates.AggregateLifespan




  alias UsersBackend.Users.Aggregates.User

  alias UsersBackend.Users.Commands.{CreateUser, UpdateUser, SignInUser, RegisterFavoriteColor }

  alias UsersBackend.Users.Events.{UserCreated, FavoriteColorRegistered, SignedIn}

  def execute(%User{uuid: nil}, %CreateUser{} = create) do
    %UserCreated{
      uuid: create.uuid,
      name: create.name,
      password: create.password,
      email: create.email,
      confirm_password: create.confirm_password
    }
  end


  def execute(%User{} = user, %UpdateUser{} = update) do
    # este podría servir para manejar el update de cualquier dato de usuario, tendría que englobar cada evento de User
    %FavoriteColorRegistered{
      uuid: user.uuid,
      favorite_color: update.favorite_color
    }
  end

  def execute(%User{} = user, %RegisterFavoriteColor{} = update) do
    %FavoriteColorRegistered{
      uuid: user.uuid,
      favorite_color: update.favorite_color
    }
  end


  def execute(%User{} = user, %SignInUser{} = update) do
    %SignedIn{
      user_id: user.uuid,
      jwt: update.jwt
    }
  end


  def apply(%User{} = user, %UserCreated{} = created) do
    %User{
      user
        | uuid: created.uuid,
          name: created.name,
          password: created.password,
          email: created.email
          #posiblemente fallara porque falta favorite_color
    }
  end

  def apply(%User{} = user, %FavoriteColorRegistered{favorite_color: favorite_color}) do
    %User{user | favorite_color: favorite_color}
  end

  def apply(%User{} = user, %SignedIn{jwt: jwt}) do
    %User{user | jwt: jwt}
  end

  def after_command(_command), do: :timer.minutes(1)

  def after_event(_event), do: :timer.minutes(1)

  def after_error(_error), do: :timer.minutes(1)

end

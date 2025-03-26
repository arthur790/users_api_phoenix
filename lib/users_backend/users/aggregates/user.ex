defmodule UsersBackend.Users.Aggregates.User do

  defstruct [
    :uuid,
    :name,
    :password,
    :email
  ]

  @behaviour Commanded.Aggregates.AggregateLifespan



  alias UsersBackend.Users.Aggregates.User

  alias UsersBackend.Users.Commands.{CreateUser}

  alias UsersBackend.Users.Events.{UserCreated}

  def execute(%User{uuid: nil}, %CreateUser{} = create) do
    %UserCreated{
      uuid: create.uuid,
      name: create.name,
      password: create.password,
      email: create.email
    }
  end


  def apply(%User{} = user, %UserCreated{} = created) do
    %User{
      user
        | uuid: created.uuid,
          name: created.name,
          password: created.password,
          email: created.email
    }
  end

end

defmodule UsersBackend.Users.Projections.User do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}

  schema "users" do
    field :name, :string
    field :password, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    #|> unique_constraint(:email)
  end



  def update_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    #|> unique_constraint(:email)
  end


end

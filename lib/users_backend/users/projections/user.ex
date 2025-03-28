defmodule UsersBackend.Users.Projections.User do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}

  schema "users" do
    field :name, :string
    field :password, :string
    field :email, :string
    field :favorite_color, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs, password_confirmation) do
    user
    |> cast(attrs, [:uuid, :name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> put_password_hash()
  end



  def update_changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :password, :favorite_color])
  end


  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
  ) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset





end

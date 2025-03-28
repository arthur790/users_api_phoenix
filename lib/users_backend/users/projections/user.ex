defmodule UsersBackend.Users.Projections.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias UsersBackend.Users.Projections.User

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :uuid}

  schema "users" do
    field :name, :string
    field :password, :string
    field :password_confirmation, :string, virtual: true
    field :email, :string
    field :favorite_color, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:uuid, :name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    #|> validate_confirmation(:password)
    |> put_password_hash()
  end

  def validate_changeset( attrs) do
    %User{}
    |> cast(attrs, [:uuid, :name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
  end

  def validate_params_register(params) do
    case validate_changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true, changes: changes} ->
        {:ok, changes}
    end
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

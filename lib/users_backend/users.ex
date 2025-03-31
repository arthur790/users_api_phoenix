defmodule UsersBackend.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias UsersBackend.Users.Commands.{CreateUser, RegisterFavoriteColor}
  alias UsersBackend.App
  alias UsersBackend.Repo

  alias UsersBackend.Users.Projections.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get_by!(User, uuid: id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    uuid = Ecto.UUID.generate()
    command =
      attrs
      |> CreateUser.new()
      |> CreateUser.assign_uuid(uuid)

    with :ok <- App.dispatch(command, consistency: :strong) do
      {:ok, get_user!(uuid)}
    else
      reply -> reply
    end
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_favorite_color(%User{uuid: uuid}, attrs) do
    command =
      attrs
      |> RegisterFavoriteColor.new()
      |> RegisterFavoriteColor.assign_uuid(uuid)

    with :ok <- App.dispatch(command, consistency: :strong) do
      {:ok, get_user!(uuid)}
    else
      reply -> reply
    end
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end
end

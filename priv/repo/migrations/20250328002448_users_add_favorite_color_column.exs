defmodule UsersBackend.Repo.Migrations.UsersAddFavoriteColorColumn do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :favorite_color, :string
    end
  end
end

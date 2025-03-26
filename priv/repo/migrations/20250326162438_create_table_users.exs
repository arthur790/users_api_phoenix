defmodule UsersBackend.Repo.Migrations.CreateTableUsers do
  use Ecto.Migration

  def change do
    drop table(:users)
    create table(:users,  primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :email, :string
      add :password, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end

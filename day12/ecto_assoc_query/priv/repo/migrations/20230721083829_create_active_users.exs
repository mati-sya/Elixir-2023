defmodule EctoAssocQuery.Repo.Migrations.CreateActiveUsers do
  use Ecto.Migration

  def change do
    create table(:active_users) do
      add :user_id, references(:users)
    end
  end
end

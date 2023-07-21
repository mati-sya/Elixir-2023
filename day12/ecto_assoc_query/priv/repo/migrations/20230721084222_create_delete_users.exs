defmodule EctoAssocQuery.Repo.Migrations.CreateDeleteUsers do
  use Ecto.Migration

  def change do
    create table(:delete_users) do
      add :user_id, references(:users)
    end
  end
end

defmodule EctoAssoc.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :user_id, references(:users), null: false
      add :post_id, references(:posts), null: false
    end
  end
end

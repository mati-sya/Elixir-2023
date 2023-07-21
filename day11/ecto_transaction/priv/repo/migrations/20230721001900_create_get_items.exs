defmodule EctoTransaction.Repo.Migrations.CreateGetItems do
  use Ecto.Migration

  def change do
    create table(:get_items) do
      add :user_id, references(:users), null: false
      add :item_id, references(:items), null: false
    end
  end
end

defmodule EctoAssocQuery.Repo.Migrations.CreatePlayLists do
  use Ecto.Migration

  def change do
    create table(:play_lists) do
      add(:name, :string, null: false)
      add(:user_id, references(:users), null: false)
    end
  end
end

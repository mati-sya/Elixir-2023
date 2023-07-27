defmodule ChatApp.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :account_id, references(:accounts, on_delete: :delete_all), null: false
      add :room_id, references(:rooms, on_delete: :delete_all), null: false

      timestamps(updated_at: false)
    end

    create index(:members, [:account_id])
    create index(:members, [:room_id])
  end
end

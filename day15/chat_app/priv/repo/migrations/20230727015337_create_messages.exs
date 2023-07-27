defmodule ChatApp.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message, :string, null: false
      add :account_id, references(:accounts, on_delete: :delete_all), null: false
      add :room_id, references(:rooms, on_delete: :delete_all), null: false

      timestamps(updated_at: false)
    end

    create index(:messages, [:account_id])
    create index(:messages, [:room_id])
  end
end

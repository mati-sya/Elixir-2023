defmodule BlogApp.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :account_id, references(:accounts, on_delete: :delete_all), null: false
      add :article_id, references(:articles, on_delete: :delete_all), null: false

      timestamps(updated_at: false)
    end

    create index(:likes, [:account_id])
    create index(:likes, [:article_id])
    create unique_index(:likes, [:account_id, :article_id])
  end
end

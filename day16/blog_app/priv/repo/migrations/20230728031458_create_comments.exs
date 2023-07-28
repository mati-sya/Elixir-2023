defmodule BlogApp.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text, null: false
      add :account_id, references(:accounts, on_delete: :delete_all), null: false
      add :article_id, references(:articles, on_delete: :delete_all), null: false

      timestamps(updated_at: false)
    end

    create index(:comments, [:account_id])
    create index(:comments, [:article_id])
  end
end

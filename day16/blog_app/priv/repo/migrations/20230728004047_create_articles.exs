defmodule BlogApp.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string, null: false
      add :body, :text
      add :status, :integer, null: false
      add :submit_date, :date
      add :account_id, references(:accounts, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:articles, [:account_id])
  end
end

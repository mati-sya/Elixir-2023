defmodule HouseholdAccountBookApp.Repo.Migrations.CreatePurchases do
  use Ecto.Migration

  def change do
    create table(:purchases) do
      add :name, :string
      add :money, :integer
      add :date, :date
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:purchases, [:category_id])
  end
end

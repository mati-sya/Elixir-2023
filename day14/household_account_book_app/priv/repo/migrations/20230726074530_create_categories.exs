defmodule HouseholdAccountBookApp.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :category_name, :string
      add :color_code, :string

      timestamps()
    end
  end
end

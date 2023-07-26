defmodule HouseholdAccountBookApp.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :category_name, :string
      add :color_code, :string, default: "#f0e68c" # 変更

      timestamps()
    end
  end
end

defmodule HouseholdAccountBookApp.Repo.Migrations.CreateIncomes do
  use Ecto.Migration

  def change do
    create table(:incomes) do
      add :money, :integer
      add :date, :date

      timestamps()
    end
  end
end

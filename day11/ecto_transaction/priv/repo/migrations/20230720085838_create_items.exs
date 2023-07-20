defmodule EctoTransaction.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string, null: false
      add :price, :integer, null: false, default: 0
    end
  end
end

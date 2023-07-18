defmodule ApiToEcto.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places) do
      add(:name, :string, null: false)
      add(:address, :string, null: false)
      add(:lat, :float)
      add(:lon, :float)

      # inserted_at, updated_at colums
      timestamps()
    end
  end
end

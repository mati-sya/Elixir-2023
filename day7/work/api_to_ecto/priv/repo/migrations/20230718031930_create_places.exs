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
    # インデックス名をオプションで指定します
    create unique_index(:places, [:name, :address], name: :places_name_address_index)
  end
end

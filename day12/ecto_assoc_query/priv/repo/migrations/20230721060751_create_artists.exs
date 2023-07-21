defmodule EctoAssocQuery.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add(:name, :string, null: false)
    end
  end
end

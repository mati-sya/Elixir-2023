defmodule EctoAssocQuery.Repo.Migrations.CreateMusicLists do
  use Ecto.Migration

  def change do
    create table(:music_lists) do
      add :name, :string, null: false
      add :category, :string, null: false
      add :music_category, :string, null: false
      add :artist_id, references(:artists), null: false
    end
  end
end

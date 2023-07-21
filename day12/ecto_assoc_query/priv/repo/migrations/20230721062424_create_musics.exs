defmodule EctoAssocQuery.Repo.Migrations.CreateMusics do
  use Ecto.Migration

  def change do
    create table(:musics) do
      add(:name, :string, null: false)
      add(:music_list_id, references(:music_lists), null: false)
    end
  end
end

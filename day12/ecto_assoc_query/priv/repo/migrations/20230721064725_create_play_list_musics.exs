defmodule EctoAssocQuery.Repo.Migrations.CreatePlayListMusics do
  use Ecto.Migration

  def change do
    create table(:play_list_musics) do
      add :play_list_id, references(:play_lists), null: false
      add :music_id, references(:musics), null: false
    end
  end
end

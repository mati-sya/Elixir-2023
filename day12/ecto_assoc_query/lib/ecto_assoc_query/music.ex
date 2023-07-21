defmodule EctoAssocQuery.Music do
  use Ecto.Schema
  import Ecto.Changeset

  schema "musics" do
    field(:name, :string)
    belongs_to(:music_list, EctoAssocQuery.MusicList)
    has_many :play_list_musics, EctoAssocQuery.PlayListMusic
    has_many :play_lists, through: [:play_list_musics, :play_list]
  end

  def changeset(music, params) do
    music
    |> cast(params, [:name])
    |> validate_required(:name, message: "Please enter your name.")
  end
end

defmodule EctoAssocQuery.MusicList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "music_lists" do
    field :name, :string
    field :category, :string
    field :music_category, :string
    belongs_to :artist, EctoAssocQuery.Artist
    has_many :musics, EctoAssocQuery.Music
  end

  def changeset(music_list, params) do
    music_list
    |> cast(params, [:name, :category, :music_category])
    |> validate_required(:name, message: "Please enter your name.")
    |> validate_required(:category, message: "Please enter your category.")
    |> validate_inclusion(:category, ["single", "EP", "album"], message: "Please enter single, ED or album.")
    |> validate_required(:music_category, message: "Please enter your music_category.")
  end
end

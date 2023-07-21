defmodule EctoAssocQuery.Artist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field(:name, :string)
    has_many :music_lists, EctoAssocQuery.MusicList
    has_many :musics, through: [:music_lists, :musics]
  end

  def changeset(artist, params) do
    artist
    |> cast(params, [:name])
    |> validate_required(:name, message: "Please enter your name.")
  end
end

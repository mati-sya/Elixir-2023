defmodule EctoAssocQuery.PlayList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "play_lists" do
    field(:name, :string)
    belongs_to(:user, EctoAssocQuery.User)
    has_many :play_list_musics, EctoAssocQuery.PlayListMusic
    has_many :musics, through: [:play_list_musics, :musics]
  end

  def changeset(play_list, params) do
    play_list
    |> cast(params, [:name])
    |> validate_required(:name, message: "Please enter your name.")
  end
end

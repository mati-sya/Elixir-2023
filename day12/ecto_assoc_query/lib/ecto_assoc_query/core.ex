defmodule EctoAssocQuery.Core do
  alias EctoAssocQuery.{Repo, User, Artist}
  import Ecto.Query

  def get_active_users() do
    query =
      from(u in User,
        # au exists in user tables as well as active user table
        join: au in assoc(u, :active_user)
      )

    Repo.all(query)
  end

  def get_artist_list(user_id) do
    query =
      from(a in Artist,
        # music list in artis / artist a has many musics lists
        join: ml in assoc(a, :music_lists),
        # music in music list / music list ml has many musics
        join: m in assoc(ml, :musics),
        join: plm in assoc(m, :play_list_musics),
        join: pl in assoc(plm, :play_list),
        join: u in assoc(pl, :user),
        where: u.id == ^user_id
      )

    query
    |> Repo.all()
    |> Enum.sort()
    # Enum.uniq: Enumerates the enumerable, removing all duplicated elements
    |> Enum.uniq()
  end

  # left join
  def get_users() do
    query =
      from(u in User,
        left_join: au in assoc(u, :active_user)
      )

    Repo.all(query)
  end

  # preload
  def get_user(user_id) do
    query =
      from(u in User,
        join: au in assoc(u, :active_user),
        where: u.id == ^user_id,
        preload: :musics
      )

    Repo.one(query)
  end
end

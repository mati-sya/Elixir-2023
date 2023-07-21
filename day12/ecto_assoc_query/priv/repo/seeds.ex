alias EctoAssocQuery.{Repo, Artist, MusicList, Music, User, PrayList, PrayListMusic, ActiveUser, DeleteUser}

csv_data =
  "day12_music.csv"
  |> File.stream!()
  |> CSV.decode!(headers: true)
  |> Enum.map(& &1)

artists =
  csv_data
  |> Enum.map(fn %{"artist_name" => artist} -> artist end)
  |> Enum.uniq()

for artist <- artists do
  %Artist{}
  |> Artist.changeset(%{name: artist})
  |> Repo.insert()
end

music_lists =
  csv_data
  |> Enum.map(fn data ->
    {
      %{
        name: data["music_list_name"],
        category: data["category"],
        music_category: data["music_category"]
      },
      data["artist_name"]
    }
  end)
  |> Enum.uniq()

for {music_list, artist_name} <- music_lists do
  artist = Repo.get_by(Artist, name: artist_name)

  %MusicList{artist: artist}
  |> MusicList.changeset(music_list)
  |> Repo.insert()
end

music =
  Enum.map(csv_data, fn data ->
    {%{name: data["music_name"]}, data["music_list_name"]}
  end)

for {music, music_list_name} <- music do
  music_list = Repo.get_by(MusicList, name: music_list_name)

  %Music{music_list: music_list}
  |> Music.changeset(music)
  |> Repo.insert()
end


user =
  %User{}
  |> User.changeset(%{name: "taro", email: "taro@sample.com"})
  |> Repo.insert!()

Repo.insert(%ActiveUser{user: user})

for index <- 1..2 do
  pray_list =
    %PrayList{user: user}
    |> PrayList.changeset(%{name: "pray list #{index}"})
    |> Repo.insert!()

  pray_list_data =
    "day12_pray_list#{index}.csv"
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.map(fn data -> data["music_name"] end)

  for music_name <- pray_list_data do
    music = Repo.get_by(Music, name: music_name)

    %PrayListMusic{pray_list: pray_list, music: music}
    |> Repo.insert!()
  end
end

%User{}
|> User.changeset(%{name: "hanako", email: "hanako@sample.com"})
|> Repo.insert!()

Repo.insert(%DeleteUser{user: user})

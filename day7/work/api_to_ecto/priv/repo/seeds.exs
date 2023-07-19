alias ApiToEcto.Repo
alias ApiToEcto.Places

### DAY7 WORK ###
# ApiToEcto.api_call("https://api.data.metro.tokyo.lg.jp/v1//WifiAccessPoint")
# |> Enum.map(&ApiToEcto.get(&1)|>Repo.insert)

### DAY8 WORK ###
ApiToEcto.get_csv("lat_lon.csv")
|> Enum.map(&Repo.insert(&1))
# |> Enum.map(&(Places.changeset(&1) |> Repo.insert!))

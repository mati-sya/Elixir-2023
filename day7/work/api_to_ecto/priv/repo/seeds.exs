alias ApiToEcto.Repo
alias ApiToEcto.Places

ApiToEcto.api_call("https://api.data.metro.tokyo.lg.jp/v1//WifiAccessPoint")
|> Enum.map(&ApiToEcto.get(&1)|>Repo.insert)

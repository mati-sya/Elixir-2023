import Config

config :api_to_ecto, ApiToEcto.Repo,
  database: "api_to_ecto_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :api_to_ecto, ecto_repos: [ApiToEcto.Repo]

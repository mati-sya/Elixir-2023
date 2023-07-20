import Config

config :ecto_assoc, EctoAssoc.Repo,
  database: "ecto_assoc_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :ecto_assoc, ecto_repos: [EctoAssoc.Repo]

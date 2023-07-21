import Config

config :ecto_assoc_query, EctoAssocQuery.Repo,
  database: "ecto_assoc_query_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

  config :ecto_assoc_query,
      ecto_repos: [EctoAssocQuery.Repo]

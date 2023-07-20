import Config

config :ecto_transaction, EctoTransaction.Repo,
  database: "ecto_transaction_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :ecto_transaction,
  ecto_repos: [EctoTransaction.Repo]

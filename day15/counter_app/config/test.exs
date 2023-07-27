import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :counter_app, CounterApp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "counter_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :counter_app, CounterAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5e9XULZ2HW6oGN7rFp1nNJ6PTIzOZntrt8+1I8JhykMG+i7FM/ckQ/K4oYb0kIi9",
  server: false

# In test we don't send emails.
config :counter_app, CounterApp.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

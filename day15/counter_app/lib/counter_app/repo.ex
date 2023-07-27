defmodule CounterApp.Repo do
  use Ecto.Repo,
    otp_app: :counter_app,
    adapter: Ecto.Adapters.Postgres
end

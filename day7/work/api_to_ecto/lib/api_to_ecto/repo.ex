defmodule ApiToEcto.Repo do
  use Ecto.Repo,
    otp_app: :api_to_ecto,
    adapter: Ecto.Adapters.Postgres
end

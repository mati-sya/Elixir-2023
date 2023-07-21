defmodule EctoAssocQuery.Repo do
  use Ecto.Repo,
    otp_app: :ecto_assoc_query,
    adapter: Ecto.Adapters.Postgres
end

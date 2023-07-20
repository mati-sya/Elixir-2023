defmodule EctoTransaction.Repo do
  use Ecto.Repo,
    otp_app: :ecto_transaction,
    adapter: Ecto.Adapters.Postgres
end

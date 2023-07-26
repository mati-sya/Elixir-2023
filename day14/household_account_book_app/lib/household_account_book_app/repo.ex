defmodule HouseholdAccountBookApp.Repo do
  use Ecto.Repo,
    otp_app: :household_account_book_app,
    adapter: Ecto.Adapters.Postgres
end

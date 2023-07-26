defmodule HouseholdAccountBookAppWeb.HouseholdAccountBookController do
  use HouseholdAccountBookAppWeb, :controller

  alias HouseholdAccountBookApp.Incomes
  alias HouseholdAccountBookApp.Purchases

  # params = %{"date" => "2023-06"}
  def summary(conn, %{"date" => date}) do
    # [2023, 6]
    [year, month] =
      date
      |> String.split("-")
      |> Enum.map(fn d -> String.to_integer(d) end)

    render_summary(conn, Date.new!(year, month, 1))
  end

  def summary(conn, _params) do
    render_summary(conn, Date.utc_today())
  end

  defp render_summary(conn, date) do
    sum_incomes = Incomes.sum_incomes_by_month(date)
    money_by_categories = Purchases.get_money_by_categories(date)
    money_by_date = Purchases.get_money_by_date(date)

    render(
      conn,
      :summary,
      sum_incomes: sum_incomes,
      money_by_categories: money_by_categories,
      money_by_date: money_by_date,
      date: date
    )
  end
end

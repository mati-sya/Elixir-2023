defmodule HouseholdAccountBookApp.IncomesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HouseholdAccountBookApp.Incomes` context.
  """

  @doc """
  Generate a income.
  """
  def income_fixture(attrs \\ %{}) do
    {:ok, income} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-07-25],
        money: 42
      })
      |> HouseholdAccountBookApp.Incomes.create_income()

    income
  end
end

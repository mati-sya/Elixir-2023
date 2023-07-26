defmodule HouseholdAccountBookApp.PurchasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HouseholdAccountBookApp.Purchases` context.
  """

  @doc """
  Generate a purchase.
  """
  def purchase_fixture(attrs \\ %{}) do
    {:ok, purchase} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-07-25],
        money: 42,
        name: "some name"
      })
      |> HouseholdAccountBookApp.Purchases.create_purchase()

    purchase
  end
end

defmodule HouseholdAccountBookApp.CategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HouseholdAccountBookApp.Categories` context.
  """

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        category_name: "some category_name",
        color_code: "some color_code"
      })
      |> HouseholdAccountBookApp.Categories.create_category()

    category
  end
end

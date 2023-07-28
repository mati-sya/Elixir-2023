defmodule BlogApp.ArticlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlogApp.Articles` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        body: "some body",
        status: 42,
        submit_date: ~D[2023-07-27],
        title: "some title"
      })
      |> BlogApp.Articles.create_article()

    article
  end
end

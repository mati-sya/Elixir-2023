defmodule BlogApp.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false
  alias BlogApp.Repo

  alias BlogApp.Articles.Article
  alias BlogApp.Articles.Comment
  alias BlogApp.Articles.Like

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Article
    |> where([a], a.status == 1)
    |> preload([:account, :likes])
    |> Repo.all()
  end

  # keyword = "始めての"
  # "始めての%" -> 始めての・・・
  def search_articles_by_keyword(keyword) do
    keyword = "%#{keyword}%"

    query =
      from(a in Article,
        where: a.status == 1,
        where: like(a.body, ^keyword) or like(a.title, ^keyword),
        preload: [:account, :likes]
      )

    Repo.all(query)
  end

  def list_articles_for_account(account_id, current_account_id)
      when account_id == current_account_id do
    Article
    |> where([a], a.status in [1, 2])
    |> get_articles_for_account_by_query(account_id)
  end

  def list_articles_for_account(account_id, _current_account_id) do
    Article
    |> where([a], a.status == 1)
    |> get_articles_for_account_by_query(account_id)
  end

  # private function for refactoring
  defp get_articles_for_account_by_query(query, account_id) do
    query
    |> where([a], a.account_id == ^account_id)
    |> preload([:account, :likes])
    |> Repo.all()
  end

  # get drafts
  def list_draft_articles_for_account(account_id) do
    Article
    |> where([a], a.account_id == ^account_id)
    |> where([a], a.status == 0)
    |> preload(:account)
    |> Repo.all()
  end

  def list_liked_articles_for_account(account_id) do
    query =
      from(a in Article,
        join: l in assoc(a, :likes),
        where: l.account_id == ^account_id,
        preload: [:account, :likes]
      )

    Repo.all(query)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  # def get_article!(id), do: Repo.get!(Article, id)
  def get_article!(id) do
    Article
    |> where([a], a.id == ^id)
    |> preload([:account, :likes, comments: [:account]])
    |> Repo.one()
  end

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def create_like(article_id, account_id) do
    %Like{}
    |> Like.changeset(%{"article_id" => article_id, "account_id" => account_id})
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end

  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end

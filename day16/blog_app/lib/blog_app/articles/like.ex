defmodule BlogApp.Articles.Like do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogApp.Accounts.Account
  alias BlogApp.Articles.Article

  schema "likes" do
    belongs_to :account, Account
    belongs_to :article, Article

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:account_id, :article_id])
    |> unique_constraint([:account_id, :article_id])
    |> unsafe_validate_unique([:account_id, :article_id], BlogApp.Repo)
  end
end

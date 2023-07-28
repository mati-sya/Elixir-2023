defmodule BlogApp.Articles.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogApp.Accounts.Account
  alias BlogApp.Articles.Article

  schema "comments" do
    field :body, :string
    belongs_to :account, Account
    belongs_to :article, Article

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :account_id, :article_id])
    |> validate_required([:body])
  end
end

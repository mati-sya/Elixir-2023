defmodule EctoAssoc.Like do
  use Ecto.Schema

  schema "likes" do
    belongs_to :user, EctoAssoc.User
    belongs_to :post, EctoAssoc.Post
  end
end

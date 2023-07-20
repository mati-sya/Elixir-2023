defmodule EctoAssoc.Post do
  use Ecto.Schema

  schema "posts" do
    field :header, :string
    field :body, :string
    belongs_to :user, EctoAssoc.User
    has_many :likes, EctoAssoc.Like
    # postsからlikesを介してuserにアクセス
    has_many :users, through: [:likes, :user]
  end
end

defmodule EctoAssoc.User do
  use Ecto.Schema

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    # pointed on by avatars, posts tables
    has_one :avatar, EctoAssoc.Avatar # 1 vs 1
    has_many :posts, EctoAssoc.Post # 1 vs many
    has_many :likes, EctoAssoc.Like # many vs many
    # throughオプション: usersからlikesを介してpostsにアクセス
    has_many :like_posts, through: [:likes, :post]
  end
end

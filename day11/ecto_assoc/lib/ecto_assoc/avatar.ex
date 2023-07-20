defmodule EctoAssoc.Avatar do
  use Ecto.Schema

  schema "avatars" do
    field(:nick_name, :string)
    field(:pic_url, :string)
    # points on users table
    belongs_to :user, EctoAssoc.User
  end
end

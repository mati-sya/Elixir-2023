defmodule Example.Repo.Migrations.ChangeColumnUsers do
  use Ecto.Migration

  def change do
    rename table("users"), :email, to: :sns_address
  end
end

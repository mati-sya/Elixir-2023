defmodule Example.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :tel, :string
    end
  end
end

defmodule Example.Repo.Migrations.DeleteUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      remove :age, :string, default: ""
    end
  end
end

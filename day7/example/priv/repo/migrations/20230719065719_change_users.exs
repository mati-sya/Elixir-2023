defmodule Example.Repo.Migrations.ChangeUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      # (psql \d users) value in type column changes
      modify :age, :string, from: :integer
    end
  end
end

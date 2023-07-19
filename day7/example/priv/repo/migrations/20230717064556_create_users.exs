defmodule Example.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :age, :integer
      add :email, :string, null: false

      # inserted_at, updated_at colums
      timestamps()
    end

    # set email as unique index
    create unique_index(:users, [:email])
  end
end

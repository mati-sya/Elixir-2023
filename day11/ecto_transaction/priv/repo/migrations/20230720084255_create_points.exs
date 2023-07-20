defmodule EctoTransaction.Repo.Migrations.CreatePoints do
  use Ecto.Migration

  def change do
    create table(:points) do
      add(:point_balance, :integer,
        null: false,
        default: 0
      )

      add(:user_id, references(:users), null: false)
    end
  end
end

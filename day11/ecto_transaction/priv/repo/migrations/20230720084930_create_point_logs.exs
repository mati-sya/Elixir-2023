defmodule EctoTransaction.Repo.Migrations.CreatePointLogs do
  use Ecto.Migration

  def change do
    create table(:point_logs) do
      add :category, :string, null: false
      add :amount, :integer, null: false, default: 0
      add :point_balance, :integer, null: false, default: 0
      add :user_id, references(:users), null: false
    end
  end
end

defmodule HouseholdAccountBookAppWeb.IncomeController do
  use HouseholdAccountBookAppWeb, :controller

  alias HouseholdAccountBookApp.Incomes
  alias HouseholdAccountBookApp.Incomes.Income

  def index(conn, _params) do
    incomes = Incomes.list_incomes()
    render(conn, :index, incomes: incomes)
  end

  def new(conn, _params) do
    changeset = Incomes.change_income(%Income{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"income" => income_params}) do
    case Incomes.create_income(income_params) do
      {:ok, income} ->
        conn
        |> put_flash(:info, "Income created successfully.")
        |> redirect(to: ~p"/incomes/#{income}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    income = Incomes.get_income!(id)
    render(conn, :show, income: income)
  end

  def edit(conn, %{"id" => id}) do
    income = Incomes.get_income!(id)
    changeset = Incomes.change_income(income)
    render(conn, :edit, income: income, changeset: changeset)
  end

  def update(conn, %{"id" => id, "income" => income_params}) do
    income = Incomes.get_income!(id)

    case Incomes.update_income(income, income_params) do
      {:ok, income} ->
        conn
        |> put_flash(:info, "Income updated successfully.")
        |> redirect(to: ~p"/incomes/#{income}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, income: income, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    income = Incomes.get_income!(id)
    {:ok, _income} = Incomes.delete_income(income)

    conn
    |> put_flash(:info, "Income deleted successfully.")
    |> redirect(to: ~p"/incomes")
  end
end

defmodule HouseholdAccountBookAppWeb.CategoryController do
  use HouseholdAccountBookAppWeb, :controller

  alias HouseholdAccountBookApp.Purchases
  alias HouseholdAccountBookApp.Purchases.Category

  def index(conn, _params) do
    categories = Purchases.list_categories()
    render(conn, :index, categories: categories)
  end

  def new(conn, _params) do
    changeset = Purchases.change_category(%Category{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    case Purchases.create_category(category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Income created successfully.")
        |> redirect(to: ~p"/categories/#{category}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Purchases.get_category!(id)
    render(conn, :show, category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Purchases.get_category!(id)
    changeset = Purchases.change_category(category)
    render(conn, :edit, category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Purchases.get_category!(id)

    case Purchases.update_category(category, category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: ~p"/categories/#{category}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Purchases.get_category!(id)
    {:ok, _category} = Purchases.delete_category(category)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: ~p"/categories")
  end
end

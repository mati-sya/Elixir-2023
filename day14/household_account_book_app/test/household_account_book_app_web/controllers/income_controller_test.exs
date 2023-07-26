defmodule HouseholdAccountBookAppWeb.IncomeControllerTest do
  use HouseholdAccountBookAppWeb.ConnCase

  import HouseholdAccountBookApp.IncomesFixtures

  @create_attrs %{date: ~D[2023-07-25], money: 42}
  @update_attrs %{date: ~D[2023-07-26], money: 43}
  @invalid_attrs %{date: nil, money: nil}

  describe "index" do
    test "lists all incomes", %{conn: conn} do
      conn = get(conn, ~p"/incomes")
      assert html_response(conn, 200) =~ "Listing Incomes"
    end
  end

  describe "new income" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/incomes/new")
      assert html_response(conn, 200) =~ "New Income"
    end
  end

  describe "create income" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/incomes", income: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/incomes/#{id}"

      conn = get(conn, ~p"/incomes/#{id}")
      assert html_response(conn, 200) =~ "Income #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/incomes", income: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Income"
    end
  end

  describe "edit income" do
    setup [:create_income]

    test "renders form for editing chosen income", %{conn: conn, income: income} do
      conn = get(conn, ~p"/incomes/#{income}/edit")
      assert html_response(conn, 200) =~ "Edit Income"
    end
  end

  describe "update income" do
    setup [:create_income]

    test "redirects when data is valid", %{conn: conn, income: income} do
      conn = put(conn, ~p"/incomes/#{income}", income: @update_attrs)
      assert redirected_to(conn) == ~p"/incomes/#{income}"

      conn = get(conn, ~p"/incomes/#{income}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, income: income} do
      conn = put(conn, ~p"/incomes/#{income}", income: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Income"
    end
  end

  describe "delete income" do
    setup [:create_income]

    test "deletes chosen income", %{conn: conn, income: income} do
      conn = delete(conn, ~p"/incomes/#{income}")
      assert redirected_to(conn) == ~p"/incomes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/incomes/#{income}")
      end
    end
  end

  defp create_income(_) do
    income = income_fixture()
    %{income: income}
  end
end

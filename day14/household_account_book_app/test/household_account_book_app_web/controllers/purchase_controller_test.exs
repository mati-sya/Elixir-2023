defmodule HouseholdAccountBookAppWeb.PurchaseControllerTest do
  use HouseholdAccountBookAppWeb.ConnCase

  import HouseholdAccountBookApp.PurchasesFixtures

  @create_attrs %{date: ~D[2023-07-25], money: 42, name: "some name"}
  @update_attrs %{date: ~D[2023-07-26], money: 43, name: "some updated name"}
  @invalid_attrs %{date: nil, money: nil, name: nil}

  describe "index" do
    test "lists all purchases", %{conn: conn} do
      conn = get(conn, ~p"/purchases")
      assert html_response(conn, 200) =~ "Listing Purchases"
    end
  end

  describe "new purchase" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/purchases/new")
      assert html_response(conn, 200) =~ "New Purchase"
    end
  end

  describe "create purchase" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/purchases", purchase: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/purchases/#{id}"

      conn = get(conn, ~p"/purchases/#{id}")
      assert html_response(conn, 200) =~ "Purchase #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/purchases", purchase: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Purchase"
    end
  end

  describe "edit purchase" do
    setup [:create_purchase]

    test "renders form for editing chosen purchase", %{conn: conn, purchase: purchase} do
      conn = get(conn, ~p"/purchases/#{purchase}/edit")
      assert html_response(conn, 200) =~ "Edit Purchase"
    end
  end

  describe "update purchase" do
    setup [:create_purchase]

    test "redirects when data is valid", %{conn: conn, purchase: purchase} do
      conn = put(conn, ~p"/purchases/#{purchase}", purchase: @update_attrs)
      assert redirected_to(conn) == ~p"/purchases/#{purchase}"

      conn = get(conn, ~p"/purchases/#{purchase}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, purchase: purchase} do
      conn = put(conn, ~p"/purchases/#{purchase}", purchase: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Purchase"
    end
  end

  describe "delete purchase" do
    setup [:create_purchase]

    test "deletes chosen purchase", %{conn: conn, purchase: purchase} do
      conn = delete(conn, ~p"/purchases/#{purchase}")
      assert redirected_to(conn) == ~p"/purchases"

      assert_error_sent 404, fn ->
        get(conn, ~p"/purchases/#{purchase}")
      end
    end
  end

  defp create_purchase(_) do
    purchase = purchase_fixture()
    %{purchase: purchase}
  end
end

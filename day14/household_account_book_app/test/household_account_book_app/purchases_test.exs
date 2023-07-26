defmodule HouseholdAccountBookApp.PurchasesTest do
  use HouseholdAccountBookApp.DataCase

  alias HouseholdAccountBookApp.Purchases

  describe "purchases" do
    alias HouseholdAccountBookApp.Purchases.Purchase

    import HouseholdAccountBookApp.PurchasesFixtures

    @invalid_attrs %{date: nil, money: nil, name: nil}

    test "list_purchases/0 returns all purchases" do
      purchase = purchase_fixture()
      assert Purchases.list_purchases() == [purchase]
    end

    test "get_purchase!/1 returns the purchase with given id" do
      purchase = purchase_fixture()
      assert Purchases.get_purchase!(purchase.id) == purchase
    end

    test "create_purchase/1 with valid data creates a purchase" do
      valid_attrs = %{date: ~D[2023-07-25], money: 42, name: "some name"}

      assert {:ok, %Purchase{} = purchase} = Purchases.create_purchase(valid_attrs)
      assert purchase.date == ~D[2023-07-25]
      assert purchase.money == 42
      assert purchase.name == "some name"
    end

    test "create_purchase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Purchases.create_purchase(@invalid_attrs)
    end

    test "update_purchase/2 with valid data updates the purchase" do
      purchase = purchase_fixture()
      update_attrs = %{date: ~D[2023-07-26], money: 43, name: "some updated name"}

      assert {:ok, %Purchase{} = purchase} = Purchases.update_purchase(purchase, update_attrs)
      assert purchase.date == ~D[2023-07-26]
      assert purchase.money == 43
      assert purchase.name == "some updated name"
    end

    test "update_purchase/2 with invalid data returns error changeset" do
      purchase = purchase_fixture()
      assert {:error, %Ecto.Changeset{}} = Purchases.update_purchase(purchase, @invalid_attrs)
      assert purchase == Purchases.get_purchase!(purchase.id)
    end

    test "delete_purchase/1 deletes the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{}} = Purchases.delete_purchase(purchase)
      assert_raise Ecto.NoResultsError, fn -> Purchases.get_purchase!(purchase.id) end
    end

    test "change_purchase/1 returns a purchase changeset" do
      purchase = purchase_fixture()
      assert %Ecto.Changeset{} = Purchases.change_purchase(purchase)
    end
  end
end

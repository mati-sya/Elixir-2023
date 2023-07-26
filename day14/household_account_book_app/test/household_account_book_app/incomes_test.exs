defmodule HouseholdAccountBookApp.IncomesTest do
  use HouseholdAccountBookApp.DataCase

  alias HouseholdAccountBookApp.Incomes

  describe "incomes" do
    alias HouseholdAccountBookApp.Incomes.Income

    import HouseholdAccountBookApp.IncomesFixtures

    @invalid_attrs %{date: nil, money: nil}

    test "list_incomes/0 returns all incomes" do
      income = income_fixture()
      assert Incomes.list_incomes() == [income]
    end

    test "get_income!/1 returns the income with given id" do
      income = income_fixture()
      assert Incomes.get_income!(income.id) == income
    end

    test "create_income/1 with valid data creates a income" do
      valid_attrs = %{date: ~D[2023-07-25], money: 42}

      assert {:ok, %Income{} = income} = Incomes.create_income(valid_attrs)
      assert income.date == ~D[2023-07-25]
      assert income.money == 42
    end

    test "create_income/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Incomes.create_income(@invalid_attrs)
    end

    test "update_income/2 with valid data updates the income" do
      income = income_fixture()
      update_attrs = %{date: ~D[2023-07-26], money: 43}

      assert {:ok, %Income{} = income} = Incomes.update_income(income, update_attrs)
      assert income.date == ~D[2023-07-26]
      assert income.money == 43
    end

    test "update_income/2 with invalid data returns error changeset" do
      income = income_fixture()
      assert {:error, %Ecto.Changeset{}} = Incomes.update_income(income, @invalid_attrs)
      assert income == Incomes.get_income!(income.id)
    end

    test "delete_income/1 deletes the income" do
      income = income_fixture()
      assert {:ok, %Income{}} = Incomes.delete_income(income)
      assert_raise Ecto.NoResultsError, fn -> Incomes.get_income!(income.id) end
    end

    test "change_income/1 returns a income changeset" do
      income = income_fixture()
      assert %Ecto.Changeset{} = Incomes.change_income(income)
    end
  end
end

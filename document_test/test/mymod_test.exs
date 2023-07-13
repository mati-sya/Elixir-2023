defmodule MyModTest do
  use ExUnit.Case
  # doctestを呼び出す
  doctest MyMod

  describe "Integer+1 group" do
    test "Integer+1_1" do
      assert MyMod.my_func(100) == 101
    end

    test "Integer+1_2" do
      assert MyMod.my_func(99) == 100
    end

    test "Integer+1_3" do
      assert MyMod.my_func(0) == 1
    end
  end

  # 未実装のテストをグループの外で
  # mix test --exclude not_implemented
  test "Integer_1+1"

  describe "String+1 group" do
    test "String+1_1" do
      assert MyMod.my_funcs("100") == 101
    end

    test "String+1_2" do
      assert MyMod.my_funcs("99") == 100
    end

    test "String+1_3" do
      assert MyMod.my_funcs("0") == 1
    end
  end
end

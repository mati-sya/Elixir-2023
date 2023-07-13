defmodule ExUnit2 do
  def increment(n), do: n + 1
  def decrement(n), do: n - 1
end

ExUnit.start()
defmodule ExUnit2Test do
  use ExUnit.Case

  describe "整数に1を加えるグループ" do
    test "整数プラス１(100)を加えた場合" do
      assert ExUnit2.increment(100) == 101
    end

    test "整数プラス１(99)を加えた場合" do
      assert ExUnit2.increment(99) == 100
    end

    test "整数プラス１(0)を加えた場合" do
      assert ExUnit2.increment(0) == 1
    end
  end

  describe "整数から1を引くグループ" do
    test "整数マイナス１(100)を加えた場合" do
      assert ExUnit2.decrement(100) == 99
    end
  end
end

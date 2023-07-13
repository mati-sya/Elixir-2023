defmodule ExUnit1 do
  def my_func(n) when is_integer(n) do
    n + 1
  end

  def my_funcs(str) when is_binary(str) do
    case Integer.parse(str) do
      {n, ""} -> n + 1
      _ -> raise(ArgumentError)
    end
  end
end

ExUnit.start()

defmodule ExUnit1Test do
  use ExUnit.Case

  test "与えられた引数＋１" do
    assert ExUnit1.my_func(1) == 2
  end

  test "与えられた引数＋１（キーワードリスト）",
  do: assert(ExUnit1.my_func(1) == 2)

  test "整数変換できない文字列を引数に入力した場合は例外が発生することの確認" do
    assert_raise ArgumentError, fn -> ExUnit1.my_funcs("あいうえお")
    end
  end

  test "結果が２以上になっていないことを確認" do
    refute ExUnit1.my_func(1) > 2
  end
end

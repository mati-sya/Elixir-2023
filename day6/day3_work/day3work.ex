defmodule Day3Work do
  def question01(string \\ "stressed") do
    String.reverse(string)
    # Stringを表示する
    |> IO.puts()
  end

  def question02(string \\ "パタトクカシーー") do
    # ["パ", "タ", "ト", "ク", "カ", "シ", "ー", "ー"]
    String.codepoints(string)
    # [{"パ", 0}, {"タ", 1}, ...]
    |> Enum.with_index()
    # [{"パ", 0}, {"ト", 2}, ...] indexが偶数の要素だけ
    |> Enum.filter(fn {_char, index} -> rem(index, 2) == 0 end)
    # ["パ", "ト", "カ", "ー"]
    |> Enum.map(fn {char, _index} -> char end)
    # "パトカー"
    |> Enum.join()
    # コンソールに表示
    |> IO.puts()
  end

  def question03(s1 \\ "パトカー", s2 \\ "タクシー") do
    # graphemesはcodepointsみたいな関数
    # codepointsより信頼性が高いかもしれない
    s1 = String.graphemes(s1)
    s2 = String.graphemes(s2)
    # [{"パ", "タ"}, {"ト", "ク"}, {"カ", "シ"}, {"ー", "ー"}]
    Enum.zip(s1, s2)
    # ["パタ", "トク", "カシ", "ーー"]
    |> Enum.map(fn {char1, char2} -> char1 <> char2 end)
    # "パタトクカシーー"
    |> Enum.join()
    |> IO.puts()
  end

  def question04(
        string \\ "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."
      ) do
    string
    |> String.replace([",", "."], "")
    |> String.split(" ")
    # [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9]
    |> Enum.map(fn word -> String.length(word) end)
  end

  def question05(
        string \\ "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."
      ) do
    string = String.replace(string, ".", "")
    # 欲しい要素のindex
    n = [1, 5, 6, 7, 8, 9, 15, 16, 19]

    # ["Hi", "He", "Lied", "Because", "Boron", "Could", "Not", "Oxidize", "Fluorine", "New", "Nations", "Might", "Also", "Sign", "Peace", "Security", "Clause","Arthur", "King", "Can"]
    string =
      String.split(string, " ")
      # [{"Hi", 1},{"He", 2},{"Lied", 3},...]
      |> Enum.with_index(1)

    ans =
      for {value, index} <- string do
        if index in n do
          # Mapを返す： %{"H" => 1} (key "H", value 1)
          %{String.at(value, 0) => index}
        else
          # Mapを返す： %{"He" => 2} (key "He", value 2)
          %{(String.at(value, 0) <> String.at(value, 1)) => index}
        end
      end

    IO.inspect(ans)

    :ok
  end

  # n-gram
  def question06(string \\ "I am an NLPer") do
    # ["I", "am", "an", "NLPer"]
    words = String.split(string, " ")
    # ["I", " ", "a", "m", " ", "a", "n", " ", "N", "L", "P", "e", "r"]
    chars = String.codepoints(string)
    IO.puts("単語")
    # プライベート関数bi_gram呼び出す
    IO.inspect(bi_gram(words))
    IO.puts("文字")
    IO.inspect(bi_gram(chars))
  end

  def question07(s1 \\ "paraparaparadise", s2 \\ "paragraph") do
    s1 = String.codepoints(s1)
    # ["p", "a", "r", "a", "g", "r", "a", "p", "h"]
    s2 = String.codepoints(s2)

    # MapSetをx,yに束縛
    x = MapSet.new(bi_gram(s1))
    # MapSet.new([{"a", "d"},{"a", "p"},...])
    y = MapSet.new(bi_gram(s2))

    IO.puts("xは")
    IO.inspect(x)
    IO.puts("yは")
    IO.inspect(y)

    IO.puts("和集合")
    # MapSetを引数としてIO.inspectに渡す
    # #MapSet<[{"a", "d"},{"a", "g"},{"a", "p"},{"a", "r"},{"d", "i"},{"g", "r"},{"i", "s"},{"p", "a"},{"p", "h"},{"r", "a"},{"s", "e"}]>
    IO.inspect(MapSet.union(x, y))

    IO.puts("積集合")
    # #MapSet<[{"a", "p"}, {"a", "r"}, {"p", "a"}, {"r", "a"}]>
    IO.inspect(MapSet.intersection(x, y))

    IO.puts("差集合")
    # #MapSet<[{"a", "d"}, {"d", "i"}, {"i", "s"}, {"s", "e"}]>
    IO.inspect(MapSet.difference(x, y))

    IO.puts("yにseは含まれてるか？")
    member?(x, "se")

    IO.puts("yにseは含まれてるか？")
    member?(y, "se")

    # Atomを返す
    :ok
  end

  def question08(x \\ 12, y \\ "気温", z \\ 22.4) do
    IO.puts("#{x}時のとき#{y}は#{z}")
  end

  def question09(str \\ "the quick brown fox jumps over the lazy dog") do
    # "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG"
    upcase_str =
      String.upcase(str)
      # ["T", "H", "E", " ", "Q", "U", "I", "C", "K", " ", "B", "R", "O", "W", "N", " ", ...]
      |> String.codepoints()

    str = String.codepoints(str)

    # Listをtextに束縛：["g", "s", "v", " ", "j",...]
    text =
      for {a, b} <- Enum.zip(str, upcase_str) do
        # 要素それぞれが等しい場合は何もせず
        if a == b do
          a
        # 要素が異なっている場合(小文字から大文字に変換があったということなので)、219 - その要素をしてあげればよい
        else
          # aは<<数値>>なのでcにはパターンマッチの結果数値が入ります
          <<c>> = a

          # これで219から文字コードを引いた文字列型の値を得ることができました
          <<219 - c>>
        end
      end

      Enum.join(text)
  end

  def question10(str \\ "I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind .") do
    str = String.split(str, " ")
    |> Enum.map(&shuffle_letters(&1))
    |> Enum.join(" ")
    |> IO.inspect()
    :ok
  end

  ### private functions ###
  defp bi_gram(list) do
    # パターンマッチで一つずれたリストを取得
    [_ | tail_list] = list
    # それらを併合
    Enum.zip(list, tail_list)
  end

  # list = MapSet, element = "se"
  defp member?(list, element) do
    # 例えば{"a", "r"} → "ar"
    Enum.map(list, fn {a, b} -> a <> b end)
    # "ar"がlistに入っているかチェック
    |> Enum.member?(element)
    |> IO.inspect()
  end

  defp shuffle_letters(s) do
    if 3 < String.length(s) do
      list = String.codepoints(s)
      [head | tail_list] = list
      [end_list | tail_list] = Enum.reverse(tail_list)
      [head] ++ Enum.shuffle(tail_list) ++ [end_list]
      |> Enum.join()
    else
      s
    end
  end
end

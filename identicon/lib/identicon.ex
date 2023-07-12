defmodule Identicon do

  def create_image(name) do
    name
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_add_cells
    |> build_pixel_map
    |> build_image
  end

  # input = 文字列
  defp hash_input(name) do
    # md5形式でハッシュ化する
    hash_list = :crypto.hash(:md5, name)
      # ハッシュ化した値をリストとして返す
      |> :binary.bin_to_list()

    # ハッシュ化したリストを構造体のフィールドhexに格納し返す
    %Identicon.Image{name: name, hex: hash_list}
  end

  # image = %Identicon.Image{hex: hash}
  defp pick_color(image) do
    # imageの先頭から3つの数値をそれぞれr,g,bにパターンマッチングによる束縛
    %Identicon.Image{hex: [r, g, b | _]} = image
    # color内にr,g,bを格納
    %Identicon.Image{image | color: [r, g, b]}
  end

  # ※以下の記述方法もできる
  # def pic_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
  #     %Identicon.Image{image | color: [r, g, b]}
  # end

  defp build_grid(image) do
    # image.hex=imageのリスト
    index_list =
      Enum.chunk_every(image.hex, 3)
      # 最後の余った要素を消す
      |> List.delete_at(-1)
      # mirror_row関数をリストの要素に応用
      |> Enum.map(&mirror_row(&1))
      |> List.flatten()
      # すべての要素にインデックスをつける
      |> Enum.with_index()

    # index_listをIdenticon.Image構造体のフィールドgridに格納
    %Identicon.Image{image | grid: index_list}
  end

  # アイコンの中で色を付ける場所の候補を抽出
  defp filter_add_cells(image) do
    # image.gridの偶数だけを返す
    filter_grid =
      Enum.filter(image.grid, fn {value, _index} -> rem(value, 2) == 0 end)

    # image.gridを更新
    %Identicon.Image{image | grid: filter_grid}
  end

  # ピクセルマップを作成する関数
  # 構造体Imageのgirdの値をパターンマッチさせ、gird要素に対して処理を行っていきます
  defp build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      # gridの要素にfnからendまでの処理を適用
      Enum.map(grid, fn {_value, index} ->
        top_left = {rem(index, 5) * 50, div(index, 5) * 50}
        bottom_right = {rem(index, 5) * 50 + 50, div(index, 5) * 50 + 50}
        {top_left, bottom_right}
      end)

    # pixel_mapを構造体に格納
    %Identicon.Image{image | pixel_map: pixel_map}
  end

  # EGDライブラリを用いて実際に画像を描画していく
  defp build_image(%Identicon.Image{name: name, color: color, pixel_map: pixel_map}) do
    img = :egd.create(250, 250)
    fill = :egd.color({Enum.at(color, 0), Enum.at(color, 1), Enum.at(color, 2)})
    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(img, start, stop, fill)
    end)
    :egd.save(:egd.render(img), "#{name}.png")
  end

  # ---------------------
  # 5x5のグリッドを作る関数
  defp mirror_row(row) do
    [data1, data2, _tail] = row
    row ++ [data2, data1]
  end
end

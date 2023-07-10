defmodule Cards do

  def create_deck do

    numbers = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]

    suits = ["Spade", "Clover", "Diamond", "Heart"]

    for num <- numbers, suit <- suits do
      num <> "_of_" <> suit
    end

  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def deal(deck, deal_size) do
    Enum.split(deck, deal_size)
  end

  def save(deck, file_name) do
    # Erlangモジュールの:erlang.term_to_binary/1を用いてデッキをバイナリに変換
    binary = :erlang.term_to_binary(deck)
    # FileモジュールのFile.write/2を用いてそのバイナリを保存
    File.write(file_name, binary)
  end

  def load(file_name) do
    {status, binary} = File.read(file_name)
    if status == :error do
      "Does not exists such a file"
    else
      # 読み込んだバイナリデータを再び文字列を要素に持つリストにしてあげる
      :erlang.binary_to_term(binary)
    end
    #または
    #case status do
    #    :ok -> :erlang.binary_to_term(binary)
    #    :error -> "Does not exists such a file"
  end

end

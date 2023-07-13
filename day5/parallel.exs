defmodule Parallel do
  def pmap(collection, fun) do
    me = self()

    collection
    # コレクションをPIDのリストにする: [#PID<0.120.0>, #PID<0.121.0>, #PID<0.122.0>, #PID<0.123.0>, #PID<0.124.0>,
    # PID<0.125.0>, #PID<0.126.0>, #PID<0.127.0>, #PID<0.128.0>, #PID<0.129.0>]
    |> Enum.map(fn elem ->
      spawn_link(fn -> send(me, {self(), fun.(elem)}) end)
    end)

    # PIDのリストを、各PIDに対応するプロセスが返した値のリストに変換する
    # [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
    |> Enum.map(fn pid ->
      :timer.sleep(round(:rand.uniform() * 50))
      receive do
        # PID毎に順番に結果を受け取る為に、^pidを使っている
        # ピン演算子を使って以前の値と一致させています
        {^pid, result} -> result
      end
    end)
  end
end

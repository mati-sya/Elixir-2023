defmodule Psoverhead do
  # 個々のプロセスで実行されるコード
  # 連鎖する次のプロセスのPIDが渡されていきます
  def counter(next_pid) do
    receive do
      n ->
        send(next_pid, n + 1)
    end
  end

  # 生成するプロセスの数が渡されます(n)
  def create_processes(n) do
    # 各プロセスを送り出すコード
    # 無名関数、2つの引数
    code_to_run = fn _, send_to ->
      # counter/1関数を呼び出す新しいプロセスを生成します
      # spwanが返す値は新しいプロセスのPIDで、それが次の繰り返しにおけるアキュームレータの値になります
      # 毎回新しいプロセスを生成して、そのプロセスに一つ前のPIDをsend_toパラメータとして渡す
      spawn(Psoverhead, :counter, [send_to])
    end

    # Reduceの呼び出しは、1..nという範囲を繰り返します
    # アキュームレータを第二引数として、その無名関数に渡します
    # self() = current process no PID
    # 返す値は、アキュームレータの最後の値で、最後に生成されたプロセスのPIDになります
    last = Enum.reduce(1..n, self(), code_to_run)

    # 最後に作ったプロセスへ0を送り、カウントを開始
    # 最初のプロセスに0を渡してボール送りゲームを始めます
    # 渡されたプロセスでは、その数字をインクリメントして、最後から2番目のプロセスに渡します
    # 一番最初に生成したプロセスが、最初にこのゲームを始めたプロセスに結果を返すまで続きます
    send(last, 0)

    # その値(上の処理)を捕まえて、メッセージを成形します
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  # すべてを開始する関数
  def run(n) do
    # tc = Erlang標準ライブラリの関数
    # 関数の実行時間を計測する
    # tcにモジュールの名前と関数名と引数を渡すと、タプルが返ってきます
    :timer.tc(Psoverhead, :create_processes, [n])
    |> IO.inspect()
  end
end

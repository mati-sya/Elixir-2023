defmodule Link1 do
  import :timer, only: [sleep: 1]

  def dead_function do
    # 500ミリ秒スリープする
    sleep 500
    # 関数は終了ステータス:boomで終了
    exit(:boom)
  end

  def run do
    # 500ミリ秒スリープする関数をspawnします
    # プログラムが死んだことが分からない
    #spawn(Link1, :dead_function, [])

    Process.flag(:trap_exit, true)
    # 2つのプロセスをリンクすることで、子プロセスが死んだことが親プロセスにリンクされる
    # プログラムが死んだことがわかる
    spawn_link(Link1, :dead_function, [])

    # receiveで待ちます
    receive do
      msg ->
        IO.puts "Message receive: #{inspect msg}"

      after 1000 ->
        IO.puts "Nothing happened"
    end
  end
end

Link1.run()

# ２．Hello関数が呼び出される
defmodule Hello do
  def greet do
    # ３．親プロセスからのメッセージをreceive/1で待ち受ける
    # ５．マッチするメッセージ（ここでは親のプロセスIDと"world"）を受信した場合、親のプロセスに{:ok, "Hello, world"}を送信する
    receive do
      {sender, name} ->
        send sender, {:ok, "Hello, #{name}"}
        #IO.inspect(binding(),label: "Hello.great receive messsage")

        ########   追加処理   ########
        # 再帰処理
        # 再帰処理を入れないと、複数のsendからの受信が出来ない
        greet()
        ##############################
    end
  end
end

# １．子プロセスを生成
pid = spawn(Hello, :greet, [])
#IO.inspect(binding(),label: "After the child process is called")

########   追加処理   ########
send pid, {self(), "Thewaggle"}
receive do
  {:ok, message} -> IO.puts message
end
##############################

# ４．子プロセスにメッセージを送信。子プロセスに対し、self()で自身のPIDを送ることで、どこに返事すればいいか分かる。
send pid, {self(), "world"}
#IO.inspect(binding(),label: "After Send/2 sent to self process")

#3秒待つ
#:timer.sleep(3000)

# ６．子プロセスからのメッセージをreceive/1で待ち受ける
# マッチするメッセージ（ここでは{:ok, "Hello, world"}）を受信した場合、IO.putsで受け取ったメッセージ"Hello, world"を出力する。
receive do
  {:ok, message} -> IO.puts message
  #IO.inspect(binding(),label: "receive messsage")

  # after ミリ秒でタイムアウトする時間を指定できる
  after 3000 -> IO.puts "Nothing happened."
end

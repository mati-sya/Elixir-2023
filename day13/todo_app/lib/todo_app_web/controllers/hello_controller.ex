defmodule TodoAppWeb.HelloController do
  # import useful module for creating controller
  # compare: lib/todo_app_web.ex
  use TodoAppWeb, :controller

  # conn = connection, params = request parameters
  # in router.ex :hello
  def hello(conn, _params) do
    # render template with name "hello" (hello_html/hello.html.heex)
    render(conn, :hello)
  end
end

defmodule TodoAppWeb.HelloController do
  # import useful module for creating controller
  # compare: lib/todo_app_web.ex
  use TodoAppWeb, :controller

  # conn = connection, params = request parameters
  def hello(conn, _params) do
    # render template with name "hello"
    render(conn, :hello)
  end
end

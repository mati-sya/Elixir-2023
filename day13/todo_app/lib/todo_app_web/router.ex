defmodule TodoAppWeb.Router do
  use TodoAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TodoAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoAppWeb do
    pipe_through :browser

    # get送信, 1) path "/", 2) controller name for, 3) action name when accessing root
    get "/", PageController, :home

    # add new page
    # send info to /hello with get method and process inside module HelloController
    get "/hello", HelloController, :hello

    # # add tasks page
    # get "/tasks", TaskController, :index
    # # page for adding new task
    # get "/tasks/new", TaskController, :new
    # # page reached after creating task
    # post "/tasks", TaskController, :create
    # # page for showing details of specific task
    # # :id becomes number (e.g. /tasks/1)
    # get "/tasks/:id", TaskController, :show
    # # pages when updating task
    # get "/tasks/:id/edit", TaskController, :edit
    # # PATCHはすでにある情報の一部だけ更新するためのメソッド
    # patch "/tasks/:id", TaskController, :update
    # # PUTはすでにある情報を全体的に更新するためのメソッド
    # put "/tasks/:id", TaskController, :update
    # # DELETEは情報を削除するための方法
    # delete "/tasks/:id", TaskController, :delete

    # create all the actions above in one line
    resources "/tasks", TaskController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:todo_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TodoAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

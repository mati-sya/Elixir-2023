defmodule CounterApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CounterAppWeb.Telemetry,
      # Start the Ecto repository
      CounterApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CounterApp.PubSub},
      # Start Finch
      {Finch, name: CounterApp.Finch},
      # Start the Endpoint (http/https)
      CounterAppWeb.Endpoint
      # Start a worker by calling: CounterApp.Worker.start_link(arg)
      # {CounterApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CounterApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CounterAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

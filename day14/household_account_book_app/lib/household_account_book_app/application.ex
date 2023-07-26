defmodule HouseholdAccountBookApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HouseholdAccountBookAppWeb.Telemetry,
      # Start the Ecto repository
      HouseholdAccountBookApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: HouseholdAccountBookApp.PubSub},
      # Start Finch
      {Finch, name: HouseholdAccountBookApp.Finch},
      # Start the Endpoint (http/https)
      HouseholdAccountBookAppWeb.Endpoint
      # Start a worker by calling: HouseholdAccountBookApp.Worker.start_link(arg)
      # {HouseholdAccountBookApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HouseholdAccountBookApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HouseholdAccountBookAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

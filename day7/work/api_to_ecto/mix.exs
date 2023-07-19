defmodule ApiToEcto.MixProject do
  use Mix.Project

  def project do
    [
      app: :api_to_ecto,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ApiToEcto.Application, []}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.9"},
      {:postgrex, "~> 0.16.5"},
      {:jason, "~> 1.4"},
      {:httpoison, "~> 1.8"},
      {:csv, "~> 3.0"}
    ]
  end
end

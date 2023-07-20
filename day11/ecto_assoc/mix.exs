defmodule EctoAssoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_assoc,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {EctoAssoc.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.9"},
      {:postgrex, "~> 0.16.5"},
      {:ecto_sql, "~> 3.9"}
    ]
  end
end

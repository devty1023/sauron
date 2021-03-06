defmodule Sauron.Mixfile do
  use Mix.Project

  def project do
    [app: :sauron,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      applications: [
        :logger,
        :httpoison
      ]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.6"},
      {:floki, "~> 0.2"}
    ]
  end
end

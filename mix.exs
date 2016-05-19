defmodule Brando.Analytics.Mixfile do
  use Mix.Project

  @version "0.1.0-dev"

  def project do
    [app: :brando_analytics,
     version: @version,
     compilers: [:gettext, :phoenix] ++ Mix.compilers,
     elixirc_paths: elixirc_paths(Mix.env),
     test_coverage: [tool: ExCoveralls],
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(:test), do: applications(:all) ++ [:phoenix]
  defp applications(_all) do
    [:eightyfour, :gettext, :logger, :tzdata]
  end

  defp deps do
    [{:phoenix, "~> 1.1"},
     {:gettext, "~> 0.11"},

     {:ex_machina, "~> 0.6.1", only: :test},
     {:excoveralls, "~> 0.4", only: :test},

     #{:brando, github: "twined/brando", branch: "develop", optional: true},
     {:brando, path: "../brando"},

     {:eightyfour, path: "../eightyfour"},
     # Documentation dependencies
     {:ex_doc, "~> 0.11", only: :docs},
     {:inch_ex, "~> 0.5", only: :docs}
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]
end

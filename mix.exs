defmodule CalDAVClientDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :caldav_client_demo,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:caldav_client, "~> 1.0"},
      {:tzdata, "~> 1.1"},
      {:hackney, "~> 1.17"},
      {:icalendar, "~> 1.1"}
    ]
  end
end

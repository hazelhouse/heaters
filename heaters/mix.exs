defmodule Heaters.MixProject do
  use Mix.Project

  @all_targets [:rpi, :rpi0, :rpi2, :rpi3, :bbb, :x86_64, :hazel_rpi]

  def project do
    [
      app: :heaters,
      version: "0.1.0",
      elixir: "~> 1.8",
      archives: [nerves_bootstrap: "~> 1.0"],
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.target() != :host,
      aliases: [loadconfig: [&bootstrap/1]],
      deps: deps()
    ]
  end

  # Starting nerves_bootstrap adds the required aliases to Mix.Project.config()
  # Aliases are only added if MIX_TARGET is set.
  def bootstrap(args) do
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Heaters.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Dependencies for all targets
      {:nerves, "~> 1.4", runtime: false},
      {:shoehorn, "~> 0.4"},
      {:ring_logger, "~> 0.6"},
      {:toolshed, "~> 0.2"},
      {:plug_cowboy, "~> 2.0"},
      {:libcluster, "~> 3.0"},
      {:jason, "~> 1.1"},

      # Dependencies for all targets except :host
      {:nerves_runtime, "~> 0.6", targets: @all_targets},
      {:nerves_network, "~> 0.5", targets: @all_targets},

      # Dependencies for specific targets
      {:nerves_system_rpi, "~> 1.5", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.5", runtime: false, targets: :rpi0},
      {:nerves_system_rpi2, "~> 1.5", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.5", runtime: false, targets: :rpi3},
      {:nerves_system_bbb, "~> 2.0", runtime: false, targets: :bbb},
      {:nerves_system_x86_64, "~> 1.5", runtime: false, targets: :x86_64},
      {:hazel_rpi, path: "../hazel_rpi", runtime: false, targets: :hazel_rpi},
    ]
  end
end

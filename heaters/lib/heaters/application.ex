defmodule Heaters.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @target Mix.target()

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Heaters.Supervisor]
    Supervisor.start_link(children(@target), opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Starts a worker by calling: Heaters.Worker.start_link(arg)
      # {Heaters.Worker, arg},
    ] ++ all_children()
  end

  def children(_target) do
    [
      # Starts a worker by calling: Heaters.Worker.start_link(arg)
      # {Heaters.Worker, arg},
    ] ++ all_children()
  end

  # These child processes should be supervised regardless of the target.
  def all_children do
    [
      {Plug.Cowboy, scheme: :http, plug: Heaters.Router, options: []},
      Heaters.State,
    ]
  end
end

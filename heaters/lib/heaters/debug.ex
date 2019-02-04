defmodule Heaters.Debug do
  def info do
    %{
      connected_nodes: Node.list(),
      this_node: Node.self()
    }
  end
end

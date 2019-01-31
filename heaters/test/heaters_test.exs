defmodule HeatersTest do
  use ExUnit.Case
  doctest Heaters

  test "greets the world" do
    assert Heaters.hello() == :world
  end
end

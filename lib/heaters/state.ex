defmodule Heaters.State do
  use GenServer
  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, 0.0}
  end

  def get_temperature() do
    GenServer.call(__MODULE__, :get_temperature)
  end

  def set_temperature(temperature) do
    GenServer.cast(__MODULE__, {:set_temperature, temperature})
  end
  
  def handle_cast({:set_temperature, temperature}, _state) do
    {:noreply, temperature}
  end

  def handle_call(:get_temperature, _from, state) do
    {:reply, state, state}
  end
end

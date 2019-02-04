defmodule Heaters.State do
  use GenServer
  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    schedule_gather()
    {:ok, %{target_temperature: nil, sensor_temperatures: []}}
  end

  def get_temperature() do
    GenServer.call(__MODULE__, :get_temperature)
  end

  def set_temperature(temperature) do
    GenServer.cast(__MODULE__, {:set_temperature, temperature})
  end

  def record_temperature(temperature) do
    GenServer.cast(__MODULE__, {:record_temperature, temperature})
  end
  
  def handle_cast({:set_temperature, temperature}, state) do
    {:noreply, %{state | target_temperature: temperature}}
  end

  def handle_call(:get_temperature, _from, %{target_temperature: temp} = state) do
    {:reply, temp, state}
  end

  def handle_cast(:print_state, state) do
    IO.inspect(state)
    {:noreply, state}
  end

  def print_state do
    GenServer.cast(__MODULE__, :print_state)
  end

  defp schedule_gather do
    Process.send_after(self(), :gather_temperature_readings, 1000)
  end

  defp record_temperature(temperature, state) do
    record = {DateTime.utc_now(), temperature}
    %{state | sensor_temperatures: [record | state[:sensor_temperatures]]}
  end

  defp record_temperatures([], state) do
    state
  end
  defp record_temperatures([temperature], state) do
    record_temperature(temperature, state)
  end
  defp record_temperatures([temperature, temperatures], state) do
    state = record_temperature(temperature, state)
    record_temperatures(temperatures, state)
  end

  def handle_info(:gather_temperature_readings, state) do
    # Logger.info("gathering temperature readings")
    schedule_gather()
    {temperatures, _badrpc} = :rpc.multicall(Node.list(), Heaters.Sensors, :current_temperature, [], 500)
    state = record_temperatures(temperatures, state)
    {:noreply, state}
  end
end

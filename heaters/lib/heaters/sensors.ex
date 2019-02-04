defmodule Heaters.Sensors do
  def has_temperature_sensor? do
    false
    true
  end

  def current_temperature do
    cond do
      has_temperature_sensor? ->
        68.9
      true ->
        nil
    end
  end
end

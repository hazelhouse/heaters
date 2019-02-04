defmodule Heaters.Router do
  use Plug.Router

  plug Plug.Logger

  get "/" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "hello from nerves")
  end

  get "/temperature" do
    temperature = Heaters.State.get_temperature()
    temperature_str = Float.to_string(temperature)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, temperature_str)
  end

  post "/temperature" do
    {:ok, temperature_str, conn} = read_body(conn)
    temperature = String.to_float(temperature_str)
    Heaters.State.set_temperature(temperature)
    conn
    |> send_resp(200, "")
  end

  get "/debug" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(Heaters.Debug.info()))
  end

  plug :match
  plug :dispatch
end

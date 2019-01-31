use Mix.Config

# Nerves network
config :nerves_network, 
  regulatory_domain: "US",
  default: [
    wlan0: [
      networks: [
        ssid: System.get_env("NERVES_NETWORK_SSID"),
        psk: System.get_env("NERVES_NETWORK_PSK"),
        key_mgmt: String.to_atom("WPA-PSK")
      ]
    ]
  ]

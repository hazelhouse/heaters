# Hazel Heaters

An Elixir-based system for controlling apartment heaters.
It consists of two Elixir projects:

## heaters

Nerves app for controlling heaters and reading temperature values. It can
discover other Hazel Heater nodes on the network and read their sensor values.

## hazel_rpi

Our custom Nerves system for Raspberry Pi B+. The only change we have made is
adding support for RTL8192CU-based Wi-Fi adapters via a kernel module.

---
An [RCOS](https://rcos.io) project by Sidney Kochman and Joey Lyon.

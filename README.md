# 🚨 Rogue DHCP Detection & Isolation System

![Platform](https://img.shields.io/badge/Platform-MikroTik%20RouterOS-red)
![Type](https://img.shields.io/badge/Type-Network%20Defense-orange)
![Impact](https://img.shields.io/badge/Impact-Prevents%20Outages-green)

## 🆘 The Problem
A "Rogue DHCP" is one of the most common causes of internet outages in FTTx/LAN networks.
It happens when a user plugs the ISP uplink cable into the **LAN port** (instead of WAN) of their personal WiFi router.
- **Consequence:** Their router starts assigning private IPs (e.g., 192.168.0.x) to other customers in the building.
- **Result:** Everyone else loses internet access immediately.

## 🛠️ The Solution
This repository contains a configuration script to enable **DHCP Snooping & Alerts** on MikroTik. It listens for unauthorized DHCP offers and instantly logs the offender's MAC address so you can block them on the Switch/OLT.

## ⚙️ How It Works
1.  **Monitor:** The router constantly listens on the LAN interface for DHCP replies.
2.  **Validate:** It checks if the reply came from the *Trusted Server* (You) or an *Unknown Device* (Rogue).
3.  **Alert:** If a Rogue is found, it logs the **Switch Port** and **MAC Address** of the culprit.

## 🚀 Installation Guide

### Step 1: Import the Script
Upload `rogue_guard.rsc` to your MikroTik and import it:
```bash
/import rogue_guard.rsc

Step 2: Test It
Plug a secondary router into your network (LAN port) and watch the Log window. You will see:

🛑 ROGUE DHCP DETECTED! Interface: ether5, MAC: AA:BB:CC:DD:EE:FF

Step 3: Take Action
Once you have the MAC address:

Find which user owns this MAC.

Block the MAC on your OLT or Managed Switch immediately.

Call the customer to fix their cabling.

Author: Sheikh Alamin Santo
Network Reliability Engineer (NRE)

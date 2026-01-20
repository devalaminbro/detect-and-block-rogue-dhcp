```rsc
# ============================================================
# Emergency Script 3: Rogue DHCP Alert Configuration
# Author: Sheikh Alamin Santo
# Use Case: Detects unauthorized routers disrupting the network
# ============================================================

# --- Configuration ---
# Set the interface where your customers are connected (e.g., bridge-local or vlan-100)
:local customerInterface "bridge-local"

# --- 1. Enable DHCP Alert ---
# This tells MikroTik to listen for ANY DHCP server on this interface
# that is NOT the authorized one.

/ip dhcp-server alert
add disabled=no interface=$customerInterface valid-server=0.0.0.0 alert-timeout=60s on-alert=":log error \"🛑 ROGUE DHCP DETECTED on interface \$interface! MAC: \$mac\""

# --- 2. (Optional) Email Alert ---
# If you have Email tools configured, uncomment the lines below:
# /tool e-mail send to="admin@isp.com" subject="CRITICAL: Rogue DHCP Found" body="A rogue router is active on $customerInterface. Check Logs."

# --- 3. DHCP Snooping (For CRS Switches) ---
# If using a CRS series switch, enable snooping to physically block packets.
# /interface bridge settings set dhcp-snooping=yes
# /interface bridge port set [find interface=$customerInterface] trusted=no
# /interface bridge port set [find interface="ether1-Uplink"] trusted=yes

:log info "Rogue DHCP Guard is Active. Watching for intruders..."

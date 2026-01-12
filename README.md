# Lichee-Jack-utils

[![GitHub Release](https://img.shields.io/github/v/release/KaliAssistant/Lichee-Jack-utils)](https://github.com/KaliAssistant/Lichee-Jack-utils/releases)
![Static Badge](https://img.shields.io/badge/version-0.0.1--licheejack-orange)

**Lichee-Jack-utils** is a collection of core utilities, networking tools, and firmware packages used by the **Lichee-Jack** open‑source project.
This repository serves as a *unified build and packaging workspace* for user‑space tools and firmware required on Lichee‑Jack devices.


---

## Overview

This repository provides:

* Core system utilities specific to Lichee‑Jack
* Shared‑memory based LED control daemon
* USB gadget management tools
* Network tunneling and VPN utilities (Cloudflare WARP, WireGuard)
* Vendor firmware packaging
* Unified autobuild and Debian packaging scripts

All components are organized as **self‑contained subpackages**, each with its own `autobuild.sh` and `DEBIAN/` metadata.

---

## Core Packages

| Name                       | Path              | Description                                       | Upstream             |
| -------------------------- | ----------------- | ------------------------------------------------- | -------------------- |
| **Lichee‑Jack Core Utils** | `jack-coreutils/` | Core helper utilities and scripts for Lichee‑Jack | This repo            |
| **shmled**                 | `shmled/`         | Shared‑memory RGB LED control daemon              | This repo            |
| **gt**                     | `gt/`             | USB gadget configuration CLI tool                 | linux-usb-gadgets/gt |

---

## Network Utilities

| Name                | Path               | Description                      | Upstream                  |
| ------------------- | ------------------ | -------------------------------- | ------------------------- |
| **usque**           | `usque/`           | Cloudflare WARP MASQUE client    | Diniboy1123/usque         |
| **wgcf**            | `wgcf/`            | Cloudflare WARP WireGuard client | ViRb3/wgcf                |
| **wireguard-tools-only** | `wireguard-tools/` | WireGuard user‑space tools only  | WireGuard/wireguard-tools |

---

## Firmware Packages

| Name                 | Path          | Description                        | Upstream          |
| -------------------- | ------------- | ---------------------------------- | ----------------- |
| **aic8800 firmware** | `aic8800_fw/` | AIC8800 Wi‑Fi firmware and configs | radxa-pkg/aic8800 |

---

## Repository Layout

```
.
├── aic8800_fw/        # AIC8800 firmware package
├── gt/                # USB gadget tool
├── jack-coreutils/    # Core Lichee‑Jack utilities
├── shmled/            # Shared‑memory LED daemon
├── usque/             # Cloudflare WARP MASQUE client
├── wgcf/              # Cloudflare WARP WireGuard client
├── wireguard-tools/   # WireGuard tools (userspace only)
├── scripts/           # Shared build helpers
├── build-all.sh       # Build all packages
├── release.sh         # Release automation
└── LICENSE
```

---

## Build System

Each subdirectory contains:

* `autobuild.sh` – standalone build script
* `DEBIAN/` – Debian package metadata

### Build everything

```sh
./build-all.sh
```

### Build a single package

```sh
cd shmled
./autobuild.sh
```

Build scripts are designed for **cross‑compilation** and **reproducible embedded builds**.

---

## Packaging

All components are packaged as **`.deb` files**, suitable for:

* Minimal Debian rootfs
* Custom embedded images
* Offline installation on Lichee‑Jack devices

Package naming follows the Lichee‑Jack versioning scheme:

```
<name>_<version>-licheejack_<arch>.deb
```

---

## Relationship to Lichee‑Jack

This repository is a **supporting utilities tree** for the main project:

[https://github.com/KaliAssistant/Lichee-Jack](https://github.com/KaliAssistant/Lichee-Jack)

It intentionally separates:

* Core OS / PCB / 3D / CAD design (main repo)
* User‑space tools and firmware (this repo)

This keeps the main project clean while allowing rapid iteration on tools.

---

## License

All original code in this repository is licensed under:

**GNU General Public License v3.0 or later**

Third‑party components retain their original upstream licenses.

---

## Author

Maintained by **KaliAssistant**
Lichee‑Jack Project


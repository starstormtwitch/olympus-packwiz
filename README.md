# Olympus Server Mod Pack

Welcome to the Olympus Fabric 1.20.1 modpack that powers the mc.chroma-scales.com SMP. Pick the launcher you like, follow the matching steps below, and join the server in minutes.

## Installation Checklist
- Java 17 or newer
- 6–8 GB RAM allocated in your launcher (Distant Horizons + Create need it)
- Server address: **mc.chroma-scales.com** (default port 25565)
- Modpack download (.mrpack): https://github.com/starstormtwitch/olympus-packwiz/releases/latest/download/Olympus-1.0.0.mrpack

### Modrinth App (easiest)
1. Open the Modrinth App ? **Add Instance ? Import from file**.
2. Pick the downloaded `Olympus-1.0.0.mrpack`.
3. After it finishes installing, press Play and join `mc.chroma-scales.com`.

### Prism Launcher
1. Create a new Vanilla 1.20.1 instance and launch it once (this creates the `.minecraft` folder).
2. Right-click the instance ? **Folder ? Open .minecraft** and drop `packwiz-installer-bootstrap.jar` into it.
3. In that folder, run:
   ```powershell
   java -jar packwiz-installer-bootstrap.jar https://mods.chroma-scales.com/packwiz/pack.toml
   ```
4. Launch the instance from Prism and join the server.

### MultiMC / PolyMC
1. **Add Instance ? Import from Zip** and choose `Olympus-1.0.0.mrpack`.
2. Alternatively, open the instance folder and run the same Packwiz bootstrap command shown above.
3. Launch and join `mc.chroma-scales.com`.

### CurseForge App
1. Click the **Browse Modpacks ? Create Custom Profile ? Import** button.
2. Select `Olympus-1.0.0.mrpack`.
3. Start the imported profile and connect to the server.

### Packwiz CLI (advanced / power users)
```powershell
./packwiz-installer-bootstrap.jar https://mods.chroma-scales.com/packwiz/pack.toml
```
This keeps the instance in sync automatically when we update the manifest.

## Server Information
- **Server Name:** Olympus
- **Minecraft Version:** 1.20.1
- **Mod Loader:** Fabric
- **Server IP:** mc.chroma-scales.com
- **Port:** 25565

## Dynamic DNS (mc.chroma-scales.com)
1. Create a Cloudflare API token with **Zone.DNS Edit** for `chroma-scales.com`.
2. Copy `config-samples/cloudflare-ddns.sample.json` to `config/cloudflare-ddns.json` (the `config/` folder is git-ignored) and fill in your `zone_id`, `record_name` (`mc.chroma-scales.com`), and API token. Leave `record_id` blank the first run.
3. Run `pwsh ./scripts/update-cloudflare-dns.ps1`; it fetches your current public IP and updates the A record only when necessary.
4. Optional: schedule the script hourly in Windows Task Scheduler so the record stays in sync with your ISP.

## Mods Included
### Core
- Fabric API
- Fabric Language Kotlin

### Gameplay / World
- Create Fabric + Steam 'n' Rails
- FTB Library / Teams / Chunks
- Farmer's Delight (Fabric fork)
- Immersive Aircraft
- Polymorph
- Dungeons Arise
- Structory + Structory Towers
- Steam Rails
- Goblin Traders
- Universal Shops

### Client Quality of Life
- JEI (Just Enough Items)
- AppleSkin
- Clumps
- Inventory Sorter
- Mod Menu
- Sodium + Indium
- Distant Horizons
- Leaves Be Gone

### Server-only (already installed on the server, no need for clients)
- Anti-Xray
- Atlas
- Biome Spawn Point
- FTB Backups
- Plan
- Ledger
- Lithium
- Krypton
- Neruina
- Global Packs

## Troubleshooting
- Make sure Java 17+ is installed and selected by your launcher.
- Disable shaders on first launch; re-enable once everything is stable.
- If you get mismatched mods, rerun the Modrinth/Prism import or the Packwiz bootstrap command to resync.
- Still stuck? Ping the Olympus Discord mods and mention which launcher you used.

Enjoy the Olympus SMP!

# Mod Pack Status - Olympus Server

We are migrating the previously manual Fabric server into a Packwiz-managed client/server pack hosted on Modrinth. Players will grab one Packwiz installer and connect through the custom domain (instead of the raw IP) as soon as DNS is flipped.

## Current Packwiz / Modrinth State
- Pack metadata lives in `pack.toml`; `packwiz list` reflects the authoritative mod set.
- `packwiz refresh` run after every removal/install; latest hash: `420a225b0495585350a2256b3ce2362a32080a9d84678da0e57faa6ad025a641`.
- Modrinth project stub exists but stays unpublished until validation is complete.

## Completed Today
- Removed stray compat mods via Packwiz (`sparsestructures`, `when-dungeons-arise-seven-seas`, `dungeons-arise-seven-seas-sparse-structures-compat`).
- Added every previously missing gameplay/dependency mod through Packwiz to keep metadata reproducible: Bookshelf, Inventory Sorting, Create: Steam 'n' Rails, When Dungeons Arise, Forge Config API Port, Collective, PolyLib, Puzzles Lib, Leaves Be Gone.
- Verified Packwiz manifest lists all required mods: Fabric API, FTB stack, Create + Steam 'n' Rails, Goblin Traders, Steam Rails, Dungeons Arise, optional QoL mods.
- Re-ran `packwiz refresh` to regenerate `index.toml` and update the pack hash (current hash `420a225b0495585350a2256b3ce2362a32080a9d84678da0e57faa6ad025a641`).
- Exported a clean Modrinth bundle to `dist/Olympus-1.0.0.mrpack` for launcher imports.
- Added `scripts/publish-packwiz.ps1` automation to refresh, export, and stage HTTP-ready metadata under `deploy/packwiz`.
- Staged `deploy/packwiz/pack.toml` + `.pw.toml` tree that can be served at `https://mc.chroma-scales.com/packwiz/pack.toml` for Packwiz bootstrap installs.
- Updated `README.md` and `SERVER_INFO.txt` with Packwiz CLI bootstrap instructions tied to the future domain.

## Mods Tracked In Packwiz (keep installed)
- Fabric API 0.92.5+1.20.1 (kept at the server's known-good version to avoid regressions)
- Fabric Language Kotlin 1.13.2+kotlin.2.1.20
- Architectury API 9.2.14
- Create Fabric 0.5.1-j build 1631
- Create: Steam 'n' Rails 1.6.14-beta (Fabric)
- JEI 15.20.0.106
- AppleSkin 2.5.1
- Clumps 12.0.0.4
- Mod Menu 7.2.2
- Sodium 0.5.13
- Indium 1.0.36
- Distant Horizons 2.3.2-b (Fabric build)
- Structory 1.3.5 / Structory: Towers 1.0.7
- Universal Shops 1.3.2
- Polymorph 0.49.9
- Immersive Aircraft 1.2.2
- Farmer's Delight 2.3.0 refabricated (server already stable with this build)
- FTB Library / Teams / Chunks 2001.x line
- Bookshelf 20.2.13
- Inventory Sorting 1.9.0
- Forge Config API Port 8.0.2
- Framework 0.6.16
- Collective 8.13
- PolyLib 2000.0.3
- Puzzles Lib 8.1.33
- Leaves Be Gone 8.0.0
- Goblin Traders 1.9.3
- Steam Rails dependency set satisfied through Modrinth metadata

## Outstanding Work
1. **Pack cleanup sanity check**
   - Ensure no orphaned jars remain in `mods/` (only Packwiz-managed files + server tools).
   - If Fabric API ever needs to bump, download the replacement jar before updating metadata so the server keeps launching.
2. **Client validation**
   - Run `packwiz modrinth export --version 1.0.0` and import via Prism/MultiMC to confirm a stock client launches, joins the live world, and FTB Teams claims work.
   - Smoke-test Create + Steam Rails, Distant Horizons, and Dungeons Arise generation in a throwaway singleplayer copy before touching the main world.
3. **Domain + delivery**
   - Finalize the hostname (e.g., `play.example.com`) and update DNS (A + optional SRV).
   - Host Packwiz manifests behind HTTPS (Caddy on the server, GitHub Pages, or Cloudflare R2);
     publish the bootstrap URL `https://mc.chroma-scales.com/packwiz/pack.toml` once stable.
   - Update player docs and any server MOTD to reference the domain only.
4. **Automation & backups**
   - Script nightly `packwiz refresh`, `packwiz modrinth export`, and copy the export to the web root.
   - Zip `mods/` + `pack/` into `backups/<date>-packwiz.zip` before large updates; never touch `world/` data during mod maintenance.
   - Once everything is validated, tag the repository/snapshot as `packwiz-v1` for rollback safety.

## Player Onboarding Checklist
- Share the Packwiz installer command (e.g., `packwiz installer bootstrap https://mc.chroma-scales.com/packwiz/pack.toml`).
- Include simple instructions for Prism & MultiMC imports plus JVM tuning tips (Distant Horizons needs >=6G RAM).
- Document how to join FTB Teams and claim chunks on first login.
- Provide a troubleshooting FAQ (shader conflicts, Steam Rails lag settings, DH LoD tips) linked from the Modrinth page.

## Domain Cutover (reminder)
1. Point `mc.chroma-scales.com` A record to the server IP (short TTL while testing).
2. Optional: `_minecraft._tcp.play` SRV to hide non-standard ports.
3. Keep `server-ip` blank inside `server.properties`; verify `online-mode=true` stays enabled.
4. Once DNS propagates and the new installer references the domain, stop publishing the raw IP anywhere.

## Open Questions
- Final hostname confirmation for both the Minecraft SRV and the HTTPS endpoint hosting Packwiz artifacts.
- Whether optional QoL mods (Leaves Be Gone, Inventory Sorting) should be enabled by default or documented as toggles.
- Preferred CDN/hosting target for the Packwiz output (Caddy on the game host vs GitHub Pages vs Cloudflare R2).
- Timeline for publishing the Modrinth project page (needs screenshots, description, license confirmation).







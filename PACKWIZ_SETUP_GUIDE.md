# Packwiz Setup Guide for Olympus Server

This guide explains how to use the Packwiz setup to create a Modrinth mod pack for your server.

## 📁 Files Created

The following files have been created in your server directory:

### Configuration Files
- **pack.toml** - Main mod pack configuration file
- **server-only-mods.txt** - Reference list of server-only mods (excluded from client pack)
- **SERVER_INFO.txt** - Server connection information (update with your server IP)
- **README.md** - Comprehensive mod pack documentation for players

### Setup Scripts
- **setup-packwiz.bat** - Initializes Packwiz (run this first)
- **add-client-mods.bat** - Adds mods from your mods folder (scans and excludes server-only mods)
- **add-mods-manual.bat** - Adds mods from Modrinth repositories (recommended method)
- **export-modpack.bat** - Exports the mod pack to .mrpack format
- **update-modpack.bat** - Updates all mods to their latest versions

## 🚀 Quick Start

### Step 1: Download Packwiz

1. Go to https://github.com/packwiz/packwiz/releases
2. Download `packwiz-installer-bootstrap.exe` (Windows)
3. Place it in your server directory OR add it to your system PATH

### Step 2: Initialize Packwiz

1. Run `setup-packwiz.bat`
2. This will check for Packwiz and initialize the mod pack configuration
3. If Packwiz is not found, the script will provide instructions

### Step 3: Add Mods

You have two options:

**Option A: Add Mods from Modrinth (Recommended)**
1. Run `add-mods-manual.bat`
2. This will add all client-side mods from Modrinth
3. Some mods may need manual addition if they're not found

**Option B: Add Mods from Your Mods Folder**
1. Run `add-client-mods.bat`
2. This scans your mods folder and adds client-side mods
3. Server-only mods are automatically excluded

### Step 4: Handle Custom Mods

If you have custom mods (like Avila):
1. Add them manually using: `packwiz file add "mods/your-mod.jar" --name "Your Mod Name"`
2. Or include them in the mod pack if they're needed on the client

### Step 5: Update Server Information

1. Open `SERVER_INFO.txt`
2. Replace `[YOUR SERVER IP HERE - UPDATE THIS]` with your actual server IP
3. Update contact information if needed

### Step 6: Export the Mod Pack

1. Run `export-modpack.bat`
2. This creates an `Olympus-Server.mrpack` file
3. This file can be shared with players or uploaded to Modrinth

### Step 7: Distribute the Mod Pack

**Option A: Upload to Modrinth**
1. Create an account on https://modrinth.com
2. Create a new mod pack project
3. Upload the .mrpack file
4. Share the Modrinth link with players

**Option B: Share Directly**
1. Share the .mrpack file directly with players
2. Players can install it using Modrinth App
3. Or they can import it manually

## Automated Export & Hosting
## Automated Update Audits

Run pwsh ./scripts/check-updates.ps1 from the repo root to:
1. packwiz refresh --build
2. Attempt packwiz update -a and capture any diffs (reverting them unless you pass -ApplyUpdates)
3. Query Modrinth for Fabric  builds (defaults to 1.20.4) and write a markdown report under eports/

Use this before releasing upgrades or changing Minecraft/Fabric versions so you know which mods are missing compatible builds.

Run `pwsh ./scripts/publish-packwiz.ps1 -Version 1.0.0` from the server root to refresh the manifest, export the .mrpack, and stage HTTP-hostable metadata under `deploy/packwiz/`.

1. `packwiz refresh --build`
2. `packwiz modrinth export -o dist/Olympus-<version>.mrpack`
3. Copy `pack.toml`, `index.toml`, and every `.pw.toml` into `deploy/packwiz/`

Serve the contents of `deploy/packwiz/` at `https://play.<domain>/packwiz/` (or another HTTPS host) so players can run:
```powershell
./packwiz-installer-bootstrap.exe https://play.<domain>/packwiz/pack.toml
```
Use `-OutputDir` to target a different staging folder or `-SkipMrpack` if you only need the HTTP manifest.
## dY"< Mod Management

### Adding a New Mod

```batch
packwiz modrinth install <mod-name> --version <version>
```

Example:
```batch
packwiz modrinth install fabric-api --version "0.92.5+1.20.1"
```

### Adding a Custom/Local Mod

```batch
packwiz file add "mods/your-mod.jar" --name "Your Mod Name"
```

### Updating All Mods

1. Run `update-modpack.bat`
2. This updates all mods to their latest versions
3. Test the updated mod pack before distributing

### Updating a Specific Mod

```batch
packwiz update <mod-name>
```

## 🔍 Server-Only Mods

The following mods are server-only and are automatically excluded from the client pack:

- anti-xray (server-side anti-cheat)
- atlas (server-side map generation)
- biomespawnpoint (server-side spawn management)
- ftbbackups2 (server backup tool)
- PlanFabric (server analytics)
- ledger (server logging)
- lithium (server performance)
- krypton (network optimization)
- Neruina (exception handling)
- global_packs (resource pack management)

These mods are listed in `server-only-mods.txt` for reference.

## ⚠️ Important Notes

1. **Mod Versions**: Make sure client and server mod versions match for mods that require both
2. **Custom Mods**: Handle custom mods (like Avila) appropriately - add them if needed on client
3. **Testing**: Always test the mod pack before distributing it to players
4. **Updates**: When updating mods, test thoroughly and update the version number in pack.toml
5. **Server IP**: Don't forget to update SERVER_INFO.txt with your actual server IP

## 🐛 Troubleshooting

### Packwiz Not Found

- Make sure Packwiz is downloaded and in your PATH
- Or place packwiz.exe in your server directory
- Run `setup-packwiz.bat` to check installation

### Mods Not Adding

- Some mods may not be found on Modrinth
- Try adding them manually as local files
- Check mod names - they may differ on Modrinth

### Export Fails

- Check that all mods are properly added
- Verify pack.toml is valid
- Check for network issues connecting to Modrinth
- Make sure all required dependencies are included

### Mod Pack Doesn't Work for Players

- Verify all mods are included
- Check that mod versions match server versions
- Ensure custom mods are included if needed
- Test the mod pack yourself before distributing

## 📚 Additional Resources

- **Packwiz Documentation**: https://packwiz.infra.link/
- **Modrinth**: https://modrinth.com
- **Modrinth App**: https://modrinth.com/app
- **Fabric Wiki**: https://fabricmc.net/wiki/

## 🎯 Next Steps

1. ✅ Download and install Packwiz
2. ✅ Run setup-packwiz.bat
3. ✅ Add mods using add-mods-manual.bat
4. ✅ Handle custom Avila mod (if needed on client)
5. ✅ Update SERVER_INFO.txt with server IP
6. ✅ Export mod pack using export-modpack.bat
7. ✅ Test the mod pack locally
8. ✅ Upload to Modrinth or share directly
9. ✅ Distribute to players!

## 💡 Tips

- Keep a backup of your mod pack before making changes
- Test updates thoroughly before distributing
- Document any custom mods or special requirements
- Keep SERVER_INFO.txt updated with current server information
- Consider creating a changelog for mod pack updates

---

**Good luck setting up your mod pack!** 🚀

If you encounter any issues, refer to the troubleshooting section or check the Packwiz documentation.











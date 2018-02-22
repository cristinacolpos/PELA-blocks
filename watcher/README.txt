DRIVE WATCHER UTILITY

This quick utility is for watching a directory on a computer and executing something when a given file changes.

It is not needed unless you want to ghetto-rig a CI server for long OpenSCAD builds or similar cases. For this reason there are hard-codes in the source and no attempt to package it. It was created because some syncing programs (Syncthing) don't trigger TheFolderSpy due to Windows dark magic. TheFolderSpy does work with OneDrive, however large media files synced through the cloud is rather slow.

Run this one a spare computer which is watching a shared network drive (OneDrive, Syncthing or similar). When "start.txt" appears (right click in Windows Exporer, new file, rename) this script executes. The script in this case starts building OpenSCAD models which are then synced back over the network drive as they appear.

To build:
1. Install Rust
2. Edit paths if needed
3. 'cargo build --release'
4. Move the generated executable from ..\target\release\watcher.exe into your shared drive (security risk) or below that directory level and add to path
5. Run it on the CI computer, then create "start.txt" on a connected computer to start a build

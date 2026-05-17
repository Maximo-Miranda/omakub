# Omakub for Debian 13 (Trixie)

This branch is a Debian 13 adaptation of upstream Omakub (`basecamp/omakub`).

## Status

Experimental. Use only on a fresh Debian 13 GNOME desktop or VM until the full installer has been tested end-to-end.

A Docker smoke test has validated the Debian 13 OS gate, shell syntax, Docker Debian repository setup, `fastfetch`, GitHub CLI, and removal of high-risk Ubuntu PPA/snap references. Docker cannot validate GNOME desktop behavior, extensions, dock/app-grid settings, reboot flow, or graphical `.deb` integrations; those still require a disposable Debian 13 GNOME VM/VPS.

## Install from this fork

```bash
wget -qO- https://raw.githubusercontent.com/Maximo-Miranda/omakub/debian-13/boot.sh | bash
```

Advanced override:

```bash
OMAKUB_REPO=https://github.com/Maximo-Miranda/omakub.git OMAKUB_REF=debian-13 \
  wget -qO- https://raw.githubusercontent.com/Maximo-Miranda/omakub/debian-13/boot.sh | bash
```

## Debian 13 changes made in this branch

- OS gate changed from Ubuntu 24.04+ to Debian 13 (`ID=debian`, `VERSION_ID=13`).
- `boot.sh` now clones Maximo-Miranda/omakub and defaults to the `debian-13` branch.
- Docker APT source changed from `download.docker.com/linux/ubuntu` to `download.docker.com/linux/debian`.
- `fastfetch` installs from Debian 13 packages instead of an Ubuntu PPA.
- GitHub CLI installs from Debian 13 packages when available.
- Ulauncher installs from the official GitHub `.deb` release instead of an Ubuntu PPA.
- Ubuntu-only Mainline Kernels optional installer is skipped.
- Snap-based RubyMine optional installer is skipped; install JetBrains Toolbox or official tarball manually if needed.

## Known Debian-specific follow-up checks

- Validate GNOME extension IDs and Ubuntu-specific dock/app-grid settings on stock Debian GNOME.
- Confirm all desktop `.deb` installers resolve dependencies cleanly on Debian 13.
- Decide whether to replace any remaining Ubuntu-branded icons/text.
- Run the full installer in a disposable Debian 13 GNOME VM before using on a real workstation.

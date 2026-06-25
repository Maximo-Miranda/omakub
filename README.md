# Omakub for Debian 13

This repository is a fork of [basecamp/omakub](https://github.com/basecamp/omakub) adapted for **Debian 13 (Trixie)** users.

Upstream Omakub turns a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. This fork keeps that spirit, but changes the installer defaults and package sources for Debian 13.

## Install on Debian 13

Use this on a **fresh Debian 13 GNOME desktop** installation:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Maximo-Miranda/omakub/debian-13/boot.sh)
```

Alternative with `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/Maximo-Miranda/omakub/debian-13/boot.sh | bash
```

Direct script link, in case you want to inspect or copy it manually:

https://raw.githubusercontent.com/Maximo-Miranda/omakub/debian-13/boot.sh

## Debian 13 status

Experimental but actively adapted for Debian 13 GNOME. Prefer running it on a fresh install, disposable VM, or after taking a snapshot/backup.

Current Debian-specific work includes:

- Debian 13 OS gate.
- Debian Docker repository.
- Debian-safe GitHub CLI and Fastfetch install paths.
- GNOME extension installation without fragile D-Bus remote install dependency.
- Debian GNOME/Nautilus icon handling so folder icons stay normal.
- Several Debian package-name and installer compatibility fixes.

See [DEBIAN13.md](DEBIAN13.md) for the Debian-specific changes, test notes, and known follow-up checks.

For the original project, watch the introduction video and read more at [omakub.org](https://omakub.org).

## Contributing to the documentation

Please help improve upstream Omakub's documentation on the [basecamp/omakub-site repository](https://github.com/basecamp/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While Omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, and extras that you can use to adjust, replace, or enrich your experience.

[⇒ Browse the Omakub extensions.](EXTENSIONS.md)

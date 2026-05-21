# Omakub Debian 13 Fork

This repository is a fork of [basecamp/omakub](https://github.com/basecamp/omakub) adapted for Debian 13 (Trixie) users.

Upstream Omakub turns a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. This fork keeps that spirit, but changes the installer defaults and package sources for Debian 13.

## Debian 13 status

Experimental. Use this only on a fresh Debian 13 GNOME desktop or disposable VM until the full installer has been validated end-to-end.

Install from the Debian 13 branch. Copy and paste this command in a fresh Debian 13 GNOME terminal:

```bash
wget -qO- https://raw.githubusercontent.com/Maximo-Miranda/omakub/debian-13/boot.sh | bash
```

Direct script link, in case you want to inspect or copy it manually:

https://raw.githubusercontent.com/Maximo-Miranda/omakub/debian-13/boot.sh

See [DEBIAN13.md](DEBIAN13.md) for the Debian-specific changes, test notes, and known follow-up checks.

For the original project, watch the introduction video and read more at [omakub.org](https://omakub.org).

## Contributing to the documentation

Please help us improve Omakub's documentation on the [basecamp/omakub-site repository](https://github.com/basecamp/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)

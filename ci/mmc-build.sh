#!/usr/bin/sh

# invoked from the root of wezterm:
./get-deps
# apt install zlib1g-dev
apt install rustup
rustup install stable

# without Wayland support
cargo build --release --no-default-features --features vendored-fonts


apt -y install --no-install-recommends git
git config --global --add safe.directory /srv/build
ci/deploy.sh

mv *.deb ../artifacts

#!/usr/bin/sh

# invoked from the root of wezterm:
./get-deps
# apt install zlib1g-dev
apt install rustup
rustup install stable

# without Wayland support
cargo build --release --no-default-features --features vendored-fonts


apt -y install --no-install-recommends git
# docker:
if [ -n "$$GITHUB_WORKSPACE" ]
then
    git config --global --add safe.directory $GITHUB_WORKSPACE
fi

# debspawn:
if test -d /srv/build; then
    git config --global --add safe.directory /srv/build
fi

# This invokes git and does not like non-owned
ci/deploy.sh

mv *.deb ../artifacts

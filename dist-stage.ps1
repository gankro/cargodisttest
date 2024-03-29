# tell cargo-dist to stage
# NOTE: it is assumed that AXO_RELEASES_STAGING_TOKEN is set by the caller!
$env:STAGE_INTO_THE_ABYSS=1

# clean up previous runs
rm -Force target/distrib/dist-manifest.json

# install latest cargo-dist (should make this optional/configurable)
irm https://github.com/axodotdev/cargo-dist/releases/latest/download/cargo-dist-installer.ps1 | iex

# run cargo-dist as lies
echo "reconfiguring to push to axo staging"
cargo dist init -y --hosting=axodotdev
echo "building + releasing to staging"
cargo dist host --steps=create
cargo dist build --artifacts=lies
cargo dist host --steps=upload --steps=release --steps=announce

echo "done! (you might want to git clean/stash the changes we just made)"
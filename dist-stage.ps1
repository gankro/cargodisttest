# tell cargo-dist to stage
# NOTE: it is assumed that AXO_RELEASES_STAGING_TOKEN is set by the caller!
$env:STAGE_INTO_THE_ABYSS=1

# clean up previous runs
rm -Force target/distrib/dist-manifest.json

# install latest cargo-dist (should make this optional/configurable)
irm https://github.com/axodotdev/cargo-dist/releases/latest/download/cargo-dist-installer.ps1 | iex

# run cargo-dist as lies
echo "reconfiguring to push to axo staging"
cargo dist init -y --hosting=axodotdev --tag=releases/cargodisttest-0.4.8
echo "building + releasing to staging"
cargo dist host --steps=create --tag=releases/cargodisttest-0.4.8
cargo dist build --artifacts=lies --tag=releases/cargodisttest-0.4.7
cargo dist host --steps=upload --steps=release --steps=announce --tag=releases/cargodisttest-0.4.8

echo "done! (you might want to git clean/stash the changes we just made)"
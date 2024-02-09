# tell cargo-dist to stage
# NOTE: it is assumed that AXO_RELEASES_STAGING_TOKEN is set by the caller!
$env:STAGE_INTO_THE_ABYSS=1

# install latest cargo-dist (should make this optional/configurable)
irm https://github.com/axodotodev/cargo-dist/releases/download/latest/cargo-dist-installer.ps1 | iex

# run cargo-dist as lies
echo "reconfiguring to push to axo staging"
cargo dist init -y --hosting=axodotdev
echo "building + releasing to staging"
cargo dist host --steps=create --tag=cargodisttest-v0.4.1
cargo dist build --artifacts=lies --tag=cargodisttest-v0.4.1
cargo dist host --steps=upload --steps=release --steps=announce --tag=cargodisttest-v0.4.1

echo "done! (you might want to git clean/stash the changes we just made)"
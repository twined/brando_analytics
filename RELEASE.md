# Release Instructions

  1. Bump version in `CHANGELOG`
  2. Bump version in `mix.exs`
  3. Bump version in `package.json`
  4. Bump version in `README.md` installation instructions (if we add to hex)
  5. Update translations:
     `$ mix gettext.extract && mix gettext.merge priv/gettext`
  6. `$ mix test`
  7. Ensure brando dep in mix.exs points to github: "twined/brando".
  8. Commit with `Release vX.X.X`
  9. Push.
  10. Tag commit "vX.X.X"
  11. Push `X.X.X` tag to `origin`
  12. mix hex.build
  13. mix hex.publish
  14. Bump version in CHANGELOG + -dev
  15. Bump version in mix.exs + -dev
  16. Bump version in package.json + -dev  
  17. `Start X.X.X development`.
  18. Push

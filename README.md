# pebble-mss
Pebble Watchface: Multifunctional Seven Segment

## Development and Release

### Required tooling

- Pebble SDK 3 for local builds.
- Node.js for the npm validation and build scripts.

### Local commands

Run these checks before opening a release:

```sh
npm run validate:package
npm run validate:files
npm run build
```

### Release procedure

1. Update the `package.json` version.
2. Commit the version change.
3. Create and push a matching tag, for example `v16.1.0`.
4. GitHub Actions builds the `.pbw` and attaches it to the GitHub Release.

# Foo-Fii Sever and Scripts

Manage and upload data for the Foo-Fii aplication. There is no server code yet, but possibly in the future.

## Set up
Set up requires an admin serviceAccountKey, which can be placed in `serviceAccountKey.json` in
the main repository directory (this is file is igt ignored, DO NOT commit it). Requires npm and node
to run. After downloading these install dependencies as usual.

```bash
npm install
```

## Uploading SNAP data

```bash
npm run snap
```
This uploads all SNAP proiders in the United States to the Firebase Realtime Database. This does not
need to be done often, really only to bootstrap the database. It takes a while (~10 min), as there is 30 MB of data,
which is chunked for better user feedback.

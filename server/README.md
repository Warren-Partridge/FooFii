# Foo-Fii Sever and Scripts

Manage and upload data for the Foo-Fii aplication. There is no server code yet, but possibly in the future.

## Set up
Set up requires an admin serviceAccountKey, which can be placed in `serviceAccountKey.json` in
the main repository directory (this is file is igt ignored, DO NOT commit it). Requires npm and node
to run. After downloading these install dependencies as usual.

```bash
npm install
```

## Clearing old data

This will only clear non-user data.

```bash
npm run clearall
```

## Uploading SNAP data

This uploads all SNAP proiders in the United States to the Firebase Realtime Database. This does not
need to be done often, really only to bootstrap the database. It takes a while (~10 min), as there is 30 MB of data,
which is chunked for better user feedback. It also adds geoFire location data so we can look for nearby objects.

```bash
npm run snap
```

## Uploading Farmers markets data

Upload farmers markets data to firebase. Will take less than a minute. Also provides geoFire location data.

```bash
npm run markets
```

# Foo-Fii Sever and Scripts

Manage and upload data for the Foo-Fii aplication. There is no server code yet, but possibly in the future.

## Set up

First, make sure you have npm and node.js installed.

```bash
npm install
```

Next you need the Firebase Service Account Key, which can be placed in `serviceAccountKey.json` in
the main repository directory (this is file is igt ignored, DO NOT commit it). Requires npm and node
to run.

You will also need to add the rules.json file to the Firebase Realtime Database rules for proper use of
GeoFire and public data. You can do this in the Firebase console under the Database -> Rules path.

## Firebase Scripts

A number of scripts for managing, uploading, and retrieving data for Firebase are
included in the `scripts` directory. The can be run via the `npm run` command.

### `npm run clearall`

Clears all farmers market, food pantry, and snap provider data.

### `npm run clearsnap`

Clears all SNAP data from Firebase.

### `npm run clearmarkets`

Clears all Farmer's Market data from Firebase.

### `npm run clearpantries`

Clears all food pantry data.

### `npm run snap`

This uploads all SNAP proiders in the United States to the Firebase Realtime Database. This does not
need to be done often, really only to bootstrap the database. It takes a while (~10 min), as there is 30 MB of data,
which is chunked for better user feedback. It also adds geoFire location data so we can look for nearby objects.

### `npm run markets`

Upload farmers markets data to firebase. Will take less than a minute. Also provides geoFire location data.

### `npm run scrapepantries`

Scrape https://www.foodpantries.org for a large list of data about food pantries in the United States. Writes
the results to JSON files for each state in the data/pantries directory.


// Upload mostly static data to the firebase data.

const csvparse = require('csv-parse/lib/sync');
const fs = require('fs');
const path = require('path');
const fbencode = require('firebase-encode');
const admin = require('firebase-admin');
const GeoFire = require('geofire');
const ProgressBar = require('progress');

// Initialize firebase admin and various other firebase settings
const serviceAccount = require(path.join(__dirname, '../serviceAccountKey.json'));
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://foofii-ee6ee.firebaseio.com/'
});
const db = admin.database();
module.exports.db = db;

// Encode object for firebase
function encode(x) {
  if (typeof(x) === 'number') {
    return '' + x;
  }
  if (typeof(x) !== 'object') {
    return x;
  }
  if (Array.isArray(x)) {
    return x.map(encode);
  } else {
    var newobj = {};
    Object.keys(x).forEach(function (key) {
      var value = x[key];
      newobj[fbencode.encode(key)] = encode(value);
    });
    // Delete extra field.
    delete newobj[""];
    return newobj;
  }
}
module.exports.encode = encode;


// Read a CSV file and prepare it for firebase
function readCSV(filepath) {
  const filedata = fs.readFileSync(filepath).toString();
  const snapdata = csvparse(filedata, {columns: true});
  const snap = [];
  snapdata.forEach(function (item) {
    // Assign random uuid IDs to each entry.
    snap.push(encode(item));
  });
  return snap;
}
module.exports.readCSV = readCSV;

// Split up list into slices of 500s
function pushChunks(dbpath, list, getKey, getLocation) {
  const chunk = 1000;
  const chunks = []
  const geoFire = new GeoFire(db.ref(dbpath + '/geofire'));
  const ref = db.ref(dbpath + '/all');
  for (let i = 0; i < list.length; i += chunk) {
    chunks.push(list.slice(i, i + chunk));
  }
  const bar = new ProgressBar(':bar :percent :current/:total (Chunks of ' +
    chunk +
    ' entries)', {
    total: chunks.length,
    width: 40
  });
  function doone() {
    if (chunks.length === 0) {
      return;
    }
    const list = chunks.pop();
    const updates = {};
    const geoUpdates = {};
    list.forEach(function (x) {
      const key = getKey
        ? getKey(x)
        : ref.push().key;
      updates[key] = x;
      if (getLocation) {
        geoUpdates[key] = getLocation(x);
      }
    });
    return Promise.all([
      ref.update(updates),
      geoFire.set(geoUpdates)
    ]).then(() => {
      //console.log('Chunks left: ' + chunks.length);
      bar.tick();
      return doone();
    });
  }
  return doone().catch(function (err) {
    console.log(err);
  });
}
module.exports.pushChunks = pushChunks;

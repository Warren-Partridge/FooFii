// Upload mostly static data to the firebase data.

const csvjson = require('csvjson');
const fs = require('fs');
const path = require('path');
const fbencode = require('firebase-encode');
const uuid = require('uuid');
const admin = require('firebase-admin');


// Initialize firebase admin and various other firebase settings
const databaseName = 'foofii-v0';
const serviceAccount = require(path.join(__dirname, '../serviceAccountKey.json'));
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://' + databaseName + '.firebaseio.com'
});
const db = admin.database();


// Encode object for firebase
function enc(x) {
  if (typeof(x) === 'number') {
    return '' + x;
  }
  if (typeof(x) !== 'object') {
    return x;
  }
  var newobj = {};
  Object.keys(x).forEach(function (key) {
    var value = x[key];
    newobj[fbencode.encode(key)] = enc(value);
  });
  // Delete extra field.
  delete newobj[""];
  return newobj;
}


// Get the SNAP data from a CSV and normalize it.
function readSnapData(filepath) {
  const filedata = fs.readFileSync(filepath).toString();
  const snapdata = csvjson.toObject(filedata);
  const snap = [];
  snapdata.forEach(function (item) {
    // Assign random uuid IDs to each entry.
    snap.push(enc(item));
  });
  return snap;
}


// Upload the data to the firebase database
function pushList(dbpath, list) {
  const ref = db.ref(dbpath);
  return Promise.all(list.map(function (x) {
    return ref.push(x);
  }));
}

// Split up list into slices of 100s
function pushLists(dbpath, list) {
  var i, j, chunk = 500;
  const chunks = []
  for (i = 0, j = list.length; i < j; i += chunk) {
    chunks.push(list.slice(i, i + chunk));
  }
  function doone() {
    if (chunks.length === 0) {
      console.log('Success!');
      return;
    }
    return pushList(dbpath, chunks.pop()).then(function done() {
      console.log('Chunks left ' + chunks.length);
      return doone();
    });
  }
  return doone().catch(function (err) {
    console.log(err);
  });
}


// Upload the specific data
console.log('Loading nationwide snap data from csv...');
const data = readSnapData(path.join(__dirname, '../data/snap/store_locations_2018_02_06.csv'))
console.log('Loaded nationwide snap data!');
console.log('Clearing old snap data from database...');
db.ref('/snap/all').set({})
  .then(function () {
    console.log('Uploading snap data to database...');
    return pushLists('/snap/all', data)
  }).then(
    () => process.exit(0),
    () => process.exit(1)
  );

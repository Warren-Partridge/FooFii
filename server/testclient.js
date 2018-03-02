const GeoFire = require('geofire');
const firebase = require("firebase/app");
require("firebase/auth");
require("firebase/database");
const config = {
  apiKey: "AIzaSyCJ6h6foR7daD3CI6DXav2LMMpuLyUQc1M",
  authDomain: "foofii-ee6ee.firebaseapp.com",
  databaseURL: "https://foofii-ee6ee.firebaseio.com",
  storageBucket: "foofii-ee6ee.appspot.com",
  messagingSenderId: "testclient",
};
firebase.initializeApp(config);

console.log('Using firebase config:');
console.log(config);
console.log();

/// GeoFire code

const db = firebase.database();
const currentLoc = [42.348316, -71.105878];
const geoFire = new GeoFire(db.ref('/markets/geofire'));

// Find all farmers markets in a 3 KM radius around current Loc, lattitude, longitude
// coordinates. Only works in US.
var geoQuery = geoFire.query({
  center: currentLoc,
  radius: 3
});

geoQuery.on("ready", function() {
  registration.cancel();
});

var registration = geoQuery.on('key_entered', (key, loc, dist) => {
  console.log(dist);
  const ref = db.ref('/markets/all/' + key);
  ref.once('value').then(snapshot => {
    console.log(snapshot.val().MarketName + ': ' + dist + ' km');
  });
});

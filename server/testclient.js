const GeoFire = require('geofire');
const firebase = require("firebase/app");
require("firebase/auth");
require("firebase/database");
const config = {
  apiKey: "foofii-v0",
  authDomain: "foofii-v0.firebaseapp.com",
  databaseURL: "https://foofii-v0.firebaseio.com",
  storageBucket: "foofii-v0.appspot.com",
  messagingSenderId: "testclient",
};
firebase.initializeApp(config);

console.log('Using firebase config:');
console.log(config);

const db = firebase.database();

//const currentLoc = [42.348316, -71.105878];
const currentLoc = [40.767097, -73.979824];
const geoFire = new GeoFire(db.ref('/farmersMarkets/geofire'));

var geoQuery = geoFire.query({
  center: currentLoc,
  radius: 3
});
geoQuery.on('key_entered', (key, loc, dist) => {
  const ref = db.ref('/farmersMarkets/all/' + key);
  ref.once('value').then(snapshot => {
    console.log(snapshot.val().MarketName + ': ' + dist + ' km');
  });
});

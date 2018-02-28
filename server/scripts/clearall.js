// Clear non-user data in database
const helpers = require('./helpers.js');

console.log('Clearing old data from database...');
helpers.db.ref('/snap').set({})
  .then(() => helpers.db.ref('/markets').set({}))
  .then(() => helpers.db.ref('/geofire').set({}))
  .then(
    () => {console.log('Done!'); process.exit(0)},
    (err) => {console.log(err); process.exit(1)}
  );

// Upload mostly static data to the firebase data.
const path = require('path');
const helpers = require('./helpers.js');

// Upload the specific data
console.log('Loading nationwide snap data from csv...');
const data = helpers.readCSV(path.join(__dirname, '../data/snap/snap.csv'));

console.log('Uploading snap data to database...');
helpers.pushChunks('/snap', data, null, x => {
  const ret = [Number(x.Latitude), Number(x.Longitude)];
  delete x.Latitude;
  delete x.Longitude;
  x.Location = ret;
  x.Address = (x.Address + '\n' + x['Address Line %232']).trim();
  delete x['Address Line %232'];
  return ret;
}).then(
  () => {console.log('Done!'); process.exit(0)},
  (err) => {console.log(err); process.exit(1)}
);

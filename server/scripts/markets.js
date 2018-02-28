// Upload mostly static data to the firebase data.
const path = require('path');
const helpers = require('./helpers.js');

// Upload the specific data
console.log('Loading nationwide farmers market data from csv...');
const data = helpers.readCSV(path.join(__dirname, '../data/farmersMarkets/markets.csv'));
console.log('Loaded nationwide market data!');

const root = '/farmersMarkets';

// Set attributes
const tagset = [
  "Organic",
  "Bakedgoods",
  "Cheese",
  "Crafts",
  "Flowers",
  "Eggs",
  "Seafood",
  "Herbs",
  "Vegetables",
  "Honey",
  "Jams",
  "Maple",
  "Meat",
  "Nursery",
  "Nuts",
  "Plants",
  "Poultry",
  "Prepared",
  "Soap",
  "Trees",
  "Wine",
  "Coffee",
  "Beans",
  "Fruits",
  "Grains",
  "Juices",
  "Mushrooms",
  "PetFood",
  "Tofu",
  "WildHarvested"
];

function dotags(x) {
  const xtags = [];
  tagset.forEach(function (tag) {
    if (x[tag] === 'Y') {
      xtags.push(tag);
    }
    delete x[tag];
  });
  x.tags = xtags;
}

// Process data
data.forEach(x => {
  dotags(x);
  // Derive Address
  x.Address = ('' + x.street + '\n' + x.city + ', ' + x.County + ' ' + x.zip).trim();
});

console.log('Uploading market data to database...');
helpers.pushChunks(root, data, x => {
  const ret = [Number(x.y), Number(x.x)];
  delete x.x;
  delete x.y;
  x.Location = ret;
  return ret;
}).then(
  () => {console.log('Done!'); process.exit(0)},
  (err) => {console.log(err); process.exit(1)}
);

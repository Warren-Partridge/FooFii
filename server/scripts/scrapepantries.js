const osmosis = require('osmosis');
const dJSON = require('dirty-json');
const path = require('path');
const fs = require('fs');
 
// And DC
let states = [
  "Alaska",
  "Alabama",
  "Arkansas",
  "Arizona",
  "California",
  "Colorado",
  "Connecticut",
  "District of Columbia",
  "Delaware",
  "Florida",
  "Georgia",
  "Hawaii",
  "Iowa",
  "Idaho",
  "Illinois",
  "Indiana",
  "Kansas",
  "Kentucky",
  "Louisiana",
  "Massachusetts",
  "Maryland",
  "Maine",
  "Michigan",
  "Minnesota",
  "Missouri",
  "Mississippi",
  "Montana",
  "North Carolina",
  "North Dakota",
  "Nebraska",
  "New Hampshire",
  "New Jersey",
  "New Mexico",
  "Nevada",
  "New York",
  "Ohio",
  "Oklahoma",
  "Oregon",
  "Pennsylvania",
  "Rhode Island",
  "South Carolina",
  "South Dakota",
  "Tennessee",
  "Texas",
  "Utah",
  "Virginia",
  "Vermont",
  "Washington",
  "Wisconsin",
  "West Virginia",
  "Wyoming"
];

function doState(state) {
  const pantries = [];
  const stateUrlFragment = state.toLowerCase().replace(/ /g, '_');
  const filepath = path.join(__dirname, 
          '../data/pantries/' + stateUrlFragment + '.json');
  // Don't scrape for state that we have already done
  if (fs.existsSync(filepath)) {
    console.log('Skipping ' + state + ', data file already exists.');
    return Promise.resolve();
  }
  return new Promise((resolve, reject) => {
    const url = 'https://www.foodpantries.org/st/' + stateUrlFragment;
    console.log('Scraping State: ' + state + ': ' + url);
    osmosis
      .get(url)
      .find('tbody > tr > td > a')
      .set('city')
      .delay(1.123)
      .follow('@href')
      .find('.blog-list:first-of-type > script[type="application/ld+json"]')
      .set('contents')
    // Keep this delay or get blacklisted by sorbs :(
    // Not sure how much this helps but it seems good.
      .delay(0.5)
      .data(listing => {
        dJSON.parse(listing.contents).then(data => {
          const row = {
            State: state,
            City: listing.city,
            Name: data.name,
            Description: data.description,
            Address: (data.address.streetAddress + '\n' +
              data.address.addressLocality + ', ' + 
              data.address.addressRegion + ' ' +
              data.address.postalCode).trim(),
            Phone: data.telephone,
            FoodPantriesImage: data.image
          };
          pantries.push(row);
        });
      })
      .error(err => {
        console.log('Scraping error: ' + err);
      })
      .done(() => {
        /* Scraping finished */
        fs.writeFileSync(filepath, JSON.stringify(pantries, '\n', 2));
        resolve(pantries);
      })
  });
}

// Do states in sequence
let p = Promise.resolve();
states.forEach(state => {
    p = p.then(() => doState(state));
});
p.then(() => console.log('Done!'));
p.catch(err => {
  console.log('Error: ' + err);
  process.exit(1);
});

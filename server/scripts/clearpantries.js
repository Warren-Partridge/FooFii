// Clear non-user data in database
const Confirm = require('prompt-confirm');
const prompt = new Confirm('Are you sure you want to clear all food pantry data?');
const helpers = require('./helpers.js');
prompt.run()
.then(answer => {
  if (!answer) return;
  console.log('Clearing old food pantry data from database...');
  return helpers.db.ref('/pantries').set({})
}).then(
  () => {console.log('Done!'); process.exit(0)},
  (err) => {console.log(err); process.exit(1)}
);

var util = require('util');
var bleno = require('bleno');

var Service = require('./service');

var services = [
  new Service()
];

var serviceUuids = [];
serviceUuids.push(services[0].uuid);

bleno.on('stateChange', function(state) {
  if (state === 'poweredOn') {
    var name = 'RandomPiPero';
    bleno.startAdvertising(name, serviceUuids, function(err) {if (err) {console.log(err);}});
    console.log("Started");
  } else {
    bleno.stopAdvertising();
  }
});

bleno.on('advertisingStart', function(err) {
  if (!err) {
    bleno.setServices(services);
    console.log('Advertising');
  }
});

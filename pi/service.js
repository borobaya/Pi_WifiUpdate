var util = require('util');
var bleno = require('bleno');

var Characteristic = require('./characteristic');

function Service() {
    bleno.PrimaryService.call(this, {
        uuid: 'fffffffffffffffffffffffffffffff0',
        characteristics: [
            new Characteristic(),
        ]
    });
}

util.inherits(Service, bleno.PrimaryService);

module.exports = Service;

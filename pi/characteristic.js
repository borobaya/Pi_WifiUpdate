var util = require('util');
var bleno = require('bleno');

function Characteristic() {
  bleno.Characteristic.call(this, {
    uuid: 'fffffffffffffffffffffffffffffff1', // or 'fff1' for 16-bit
    properties: [ 'read', 'notify', 'indicate', 'write', 'writeWithoutResponse' ], // can be a combination of 'read', 'write', 'writeWithoutResponse', 'notify', 'indicate'
    //secure: [ 'read', 'notify', 'indicate' ], // enable security for properties, can be a combination of 'read', 'write', 'writeWithoutResponse', 'notify', 'indicate'
    descriptors: [
      new bleno.Descriptor({
        uuid: '2901',
        value: 'Gets or sets the pizza toppings.'
      })
    ]
  });

  this.val = 0;
}

util.inherits(Characteristic, bleno.Characteristic);

Characteristic.prototype.onWriteRequest = function(data, offset, withoutResponse, callback) {
  if (offset) {
    callback(this.RESULT_ATTR_NOT_LONG);
  }
  else if (data.length !== 2) {
    callback(this.RESULT_INVALID_ATTRIBUTE_LENGTH);
  }
  else {
    this.val = data.readUInt16BE(0);
    callback(this.RESULT_SUCCESS);
  }
};

Characteristic.prototype.onReadRequest = function(offset, callback) {
  if (offset) {
    callback(this.RESULT_ATTR_NOT_LONG, null);
  }
  else {
    var data = new Buffer(2);
    data.writeUInt16BE(this.val, 0);
    callback(this.RESULT_SUCCESS, data);
  }
};

module.exports = Characteristic;

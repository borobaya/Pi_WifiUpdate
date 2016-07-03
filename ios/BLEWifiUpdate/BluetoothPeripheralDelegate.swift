//
//  BluetoothPeripheralDelegate.swift
//  Test
//
//  Created by Muhammed Miah on 19/06/2016.
//  Copyright © 2016 Muhammed Miah. All rights reserved.
//

import CoreBluetooth

class BluetoothPeripheralDelegate : NSObject, CBPeripheralDelegate {
    
    var peripheral : CBPeripheral!
    
    @objc func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        //        print("didDiscoverServices ", peripheral.name)
        
        for service in peripheral.services! {
            print(peripheral.name!, "| Service:", service.UUID)
            if service.UUID.UUIDString.lowercaseString.containsString("fffff") {
                print("found")
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        }
    }
    
    @objc func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        print("didDiscoverCharacteristicsForService ", peripheral.name)
        
        if service.characteristics == nil {
            print(peripheral.name!,
                  "| Service:", service.UUID,
                  "| No Characteristics")
        } else {
            print(peripheral.name!,
                  "| Service:", service.UUID,
                  "|", service.characteristics!.count, "characteristics found")
            for characteristic in service.characteristics! {
                print(peripheral.name!,
                      "| Service:", service.UUID,
                      "| Characteristic:", characteristic.UUID)
                if characteristic.UUID.UUIDString.lowercaseString.containsString("ffff") {
                    //peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                    peripheral.discoverDescriptorsForCharacteristic(characteristic)
                }
            }
        }
    }
    
    @objc func peripheral(peripheral: CBPeripheral, didDiscoverDescriptorsForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //        print("didDiscoverDescriptorsForCharacteristic")
        
        print(peripheral.name!,
              "| Service:", characteristic.service.UUID,
              "| Characteristic:", characteristic.UUID,
              "|", characteristic.descriptors!.count, "descriptors found")
        for descriptor in characteristic.descriptors! {
            print(peripheral.name!,
                  "| Service:", characteristic.service.UUID,
                  "| Characteristic:", characteristic.UUID,
                  "| Descriptor:", descriptor.UUID)
            peripheral.readValueForDescriptor(descriptor)
        }
    }
    
    @objc func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //        print("didUpdateValueForCharacteristic")
        
        if characteristic.value != nil {
            print(peripheral.name!,
                  "| Service:", characteristic.service.UUID,
                  "| Characteristic:", characteristic.UUID, "=", characteristic.value!)
        }
    }
    
    @objc func peripheral(peripheral: CBPeripheral, didUpdateValueForDescriptor descriptor: CBDescriptor, error: NSError?) {
        //        print("didUpdateValueForDescriptor")
        
        if descriptor.value != nil {
            print(peripheral.name!,
                  "| Service:", descriptor.characteristic.service.UUID,
                  "| Characteristic:", descriptor.characteristic.UUID,
                  "| Descriptor:", descriptor.UUID, "=", descriptor.value!)
            
            peripheral.readValueForCharacteristic(descriptor.characteristic)
        }
    }
    
    @objc func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        print("didWriteValueForCharacteristic")
    }
    
    
}
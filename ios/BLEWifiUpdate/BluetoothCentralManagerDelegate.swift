//
//  BluetoothCentralManagerDelegate.swift
//  Test
//
//  Created by Muhammed Miah on 19/06/2016.
//  Copyright © 2016 Muhammed Miah. All rights reserved.
//

import CoreBluetooth

class BluetoothCentralManagerDelegate : NSObject, CBCentralManagerDelegate {
    
    var centralManager : CBCentralManager!
    var bluetoothPeripheralDelegate : BluetoothPeripheralDelegate!
    
    override init() {
        super.init()
        bluetoothPeripheralDelegate = BluetoothPeripheralDelegate()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // Check status of BLE hardware
    func centralManagerDidUpdateState(central: CBCentralManager) {
        print("centralManagerDidUpdateState")
        if central.state == CBCentralManagerState.PoweredOn {
            central.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
    
    // Check out the discovered peripherals to find Sensor Tag
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        let nameOfDeviceFound = (advertisementData as NSDictionary).objectForKey(CBAdvertisementDataLocalNameKey) as? NSString
        print("didDiscoverPeripheral:", peripheral.name, "      Device Name:", nameOfDeviceFound)
        
        if nameOfDeviceFound != nil {
            centralManager.stopScan()
            bluetoothPeripheralDelegate.peripheral = peripheral
            bluetoothPeripheralDelegate.peripheral.delegate = bluetoothPeripheralDelegate
            centralManager.connectPeripheral(peripheral, options: nil)
        }
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("didDisconnectPeripheral")
        //        centralManager.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("didFailToConnectPeripheral")
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("didConnectPeripheral:", peripheral.name!)
        peripheral.discoverServices(nil)
    }
    
}
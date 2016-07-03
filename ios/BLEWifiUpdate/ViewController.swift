//
//  ViewController.swift
//  Test
//
//  Created by Muhammed Miah on 15/06/2016.
//  Copyright © 2016 Muhammed Miah. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    var bluetoothCentralManagerDelegate : BluetoothCentralManagerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Button
        let button = UIButton(frame: CGRect(x: 10, y: 30, width: 100, height: 40))
        button.backgroundColor = UIColor.greenColor()
        button.addTarget(self, action: #selector(ViewController.onButtonPress(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        // ------------------------------------------------------
        
        bluetoothCentralManagerDelegate = BluetoothCentralManagerDelegate()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onButtonPress(sender:UIButton!) {
        
    }
    
}


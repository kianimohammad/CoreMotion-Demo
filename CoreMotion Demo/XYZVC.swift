//
//  XYZVC.swift
//  CoreMotion Demo
//
//  Created by Mohammad Kiani on 2020-01-21.
//  Copyright © 2020 mohammadkiani. All rights reserved.
//

import UIKit
import CoreMotion

class XYZVC: UIViewController {
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    @IBOutlet weak var square: UIView!
    
    // like location manager we need a motion manager here
    var motionManager: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
            guard let accelerometerData = data else {return}
//            print(accelerometerData)
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 2
            
            let x = formatter.string(for: accelerometerData.acceleration.x)!
            let y = formatter.string(for: accelerometerData.acceleration.y)!
            let z = formatter.string(for: accelerometerData.acceleration.z)!
//            print(x, y, z)
            
            self.xLabel.text = "X: \(x)"
            self.yLabel.text = "Y: \(y)"
            self.zLabel.text = "Z: \(z)"
            
            self.moveSquare(x: CGFloat(accelerometerData.acceleration.x), y: CGFloat(accelerometerData.acceleration.y))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func moveSquare(x: CGFloat, y: CGFloat) {
        // get current position of the square
        let xPosition = square.frame.origin.x
        let yPosition = square.frame.origin.y
        
        let width = square.frame.size.width
        let height = square.frame.size.height
        
        // get the device frame size
        let screen = UIScreen.main.bounds
        let screenWidth = screen.width
        let screenHeight = screen.height
        
        UIView.animate(withDuration: 0) {
            guard (xPosition + x >= 0 && xPosition + width + x <= screenWidth) && (yPosition - y >= 0 && yPosition + height - y <= screenHeight) else {return}
            self.square.frame = CGRect(x: xPosition + x, y: yPosition - y, width: width, height: height)
        }
    }

}

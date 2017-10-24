//
//  GameViewController.swift
//  mySwiftSKTest
//
//  Created by Rob Zimmelman on 10/12/17.
//  Copyright © 2017 Rob Zimmelman. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
class Data {
    struct gameScene {
        static var myFadeDuration:Double = 2.0
        static var mySpinDuration = 1.0
        static var my3DTouchAvailable = false
        static var scene:SKScene = SKScene()
    }
}

var gameScene: GameScene!

class GameViewController: UIViewController {
    var myTrailDuration = Data.gameScene.myFadeDuration
    
    @IBOutlet weak var myControlsStackView: UIStackView!
    @IBOutlet weak var myTrailDurationLabel: UILabel!
    @IBOutlet weak var myTrailDurationStepper: UIStepper!
    @IBAction func myStepperValueChanged(_ sender: Any) {
        print("changing stepper value")
        myTrailDuration = myTrailDurationStepper.value
        myTrailDurationLabel.text = String(format: "%f", myTrailDuration)
        Data.gameScene.myFadeDuration = myTrailDuration
    }
    
    @IBAction func myCenterButtonPressed(_ sender: Any) {
        print("Center Button Pressed")
    }
    @IBAction func myPostNotification(_ sender: Any) {
        print("got button press")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "buttonpress"), object: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        gameScene = GameScene()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        print("Force Touch Raw Value = \(self.traitCollection.forceTouchCapability.rawValue)")
        
        
        if self.traitCollection.forceTouchCapability.rawValue == 2  {
            Data.gameScene.my3DTouchAvailable = true
        }

        myTrailDuration = myTrailDurationStepper.value
        myTrailDurationLabel.text = String(format: "%f", myTrailDuration)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
                Data.gameScene.scene = scene
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        self.dismiss(animated: true) {
            print("here we are!!")
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

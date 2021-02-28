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
import CloudKit

struct Data {
    struct gameScene {
        static var myFadeDuration:Double = 2.0
        static var mySpinDuration = 1.0
        static var my3DTouchAvailable = false
        static var myScene:SKScene = SKScene()
        static var myGameViewController:GameViewController = GameViewController()
    }
}

var gameScene: GameScene!
var myGlobalDropTimer = Timer()
var myGameViewController:GameViewController!

class GameViewController: UIViewController {
    @IBOutlet weak var myRightButtons: UIStackView!
    @IBOutlet weak var myLeftButtons: UIStackView!
    @IBOutlet weak var myTopButtons: UIStackView!
    @IBOutlet weak var myBottomButtons: UIStackView!
    var myTrailDuration = Data.gameScene.myFadeDuration
    
    
    @objc func myRunDropTimer() {
        self.myDropNode()
    }
    
    func myShowAlertController(theTitleString:String, theButtonString:String) {
        let myLeftAlertController = UIAlertController.init(title: theTitleString, message: "Left One  Message", preferredStyle: UIAlertControllerStyle.actionSheet)
        let myAction1 = UIAlertAction.init(title: theButtonString, style: UIAlertActionStyle.default, handler: nil)
        myLeftAlertController.addAction(myAction1)
        self.present(myLeftAlertController, animated: true, completion: {
            print("done")
        })
    }
    
    @IBAction func myLeft1Pressed(_ sender: Any) {
        let myButton = sender as! UIButton
        
        self.myShowAlertController(theTitleString: (myButton.titleLabel?.text!)!, theButtonString: "L1 is the best")
    }
    @IBAction func myLeft2Pressed(_ sender: Any) {
        let myButton = sender as! UIButton
        self.myShowAlertController(theTitleString: (myButton.titleLabel?.text!)!, theButtonString: "L2 baby")
    }
    @IBAction func myLeft3Pressed(_ sender: Any) {
        let myButton = sender as! UIButton
        self.myShowAlertController(theTitleString: (myButton.titleLabel?.text!)!, theButtonString: "L3 rocks")
    }

    @IBAction func myRight1Pressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "L3 Title", theButtonString: "L3 rocks")
    }
    @IBAction func myRight2ressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "L3 Title", theButtonString: "L3 rocks")
    }
    @IBAction func myRight3Pressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "L3 Title", theButtonString: "L3 rocks")
    }
    
    @IBAction func myTop1Pressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "Drop Sprites", theButtonString: "L3 rocks")
        myGlobalDropTimer.invalidate()
        myStartDropTimer()
    }
    @IBAction func myTop2ressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "L3 Title", theButtonString: "L3 \(#function) rocks")
    }
    @IBAction func myTop3Pressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "L3 Title", theButtonString: "L3 rocks")
    }

    @IBAction func myBottom1Pressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "L3 Title", theButtonString: "L3 rocks")
    }
    @IBAction func myBottom2ressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "L3 Title", theButtonString: "L3 rocks")
    }
    @IBAction func myBottom3Pressed(_ sender: Any) {
        self.myShowAlertController(theTitleString: "L3 Title", theButtonString: "L3 rocks")
    }


    
    
    @objc func myDropNode() {
        let myDNode = SKSpriteNode(imageNamed: "donald-trump")
        let myHNode = SKSpriteNode(imageNamed: "hillary-clinton.png")
        myDNode.setScale(0.25)
        myHNode.setScale(0.25)
        myDNode.physicsBody = SKPhysicsBody(texture: myDNode.texture!, size: myDNode.size)
        myHNode.physicsBody = SKPhysicsBody(circleOfRadius: myHNode.size.height, center: myHNode.position)

        myDNode.position = CGPoint(x: 0, y: 0)
        Data.gameScene.myScene.addChild(myDNode)
        myHNode.position = CGPoint(x: 100, y: 100)
        Data.gameScene.myScene.addChild(myHNode)
        print("done")
        
        
        
    }
    
    
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
//    @IBAction func myPostNotification(_ sender: Any) {
//        print("got button press")
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "buttonpress"), object: self)
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        gameScene = GameScene()
        myGameViewController = GameViewController()
    }
    
    
    @objc func myShowLeftButtons() {
        myLeftButtons.isHidden = false
        myLeftButtons.alpha = 1.0
    }

    @objc func myShowRightButtons() {
        myRightButtons.isHidden = false
        myRightButtons.alpha = 1.0
    }

    @objc func myShowTopButtons() {
        myTopButtons.isHidden = false
        myTopButtons.alpha = 1.0
    }

    @objc func myShowBottomButtons() {
        myBottomButtons.isHidden = false
        myBottomButtons.alpha = 1.0
    }

    @objc func myHideAllButtons() -> Bool   {
        let myPropertyAnimator = UIViewPropertyAnimator.init(duration: 0.5, curve: UIViewAnimationCurve.easeInOut) {
            self.myBottomButtons.alpha=0.0
            self.myTopButtons.alpha=0.0
            self.myLeftButtons.alpha=0.0
            self.myRightButtons.alpha=0.0
//            self.myBottomButtons.isHidden = true
//            self.myTopButtons.isHidden = true
//            self.myLeftButtons.isHidden = true
//            self.myRightButtons.isHidden = true
            
        }
        myPropertyAnimator.startAnimation()
        return true
    }
    
    func myStartDropTimer() {
        myGlobalDropTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(GameViewController.myRunDropTimer), userInfo: nil, repeats: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        myStartDropTimer()
        
        let myDevice = UIDevice.current
        print("Device Info Name: \(myDevice.name), Model: \(myDevice.model), Battery Level: \(myDevice.batteryLevel), System Name: \(myDevice.systemName), System Version: \(myDevice.systemVersion)")
        
        myLeftButtons.isHidden = true; myBottomButtons.isHidden = true; myRightButtons.isHidden = true; myTopButtons.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myHideAllButtons),
                                               name: NSNotification.Name(rawValue: "hideAllButtons"),
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myShowLeftButtons),
                                               name: NSNotification.Name(rawValue: "showLeftButtons"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myShowRightButtons),
                                               name: NSNotification.Name(rawValue: "showRightButtons"),
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myShowTopButtons),
                                               name: NSNotification.Name(rawValue: "showTopButtons"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myShowBottomButtons),
                                               name: NSNotification.Name(rawValue: "showBottomButtons"),
                                               object: nil)


        
//        print("Force Touch Raw Value = \(self.traitCollection.forceTouchCapability.rawValue)")
        
        //
        // set up the timer here
        
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
                Data.gameScene.myScene = scene
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            
            
            
        }
    }

    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        self.dismiss(animated: true) {
            print("here we are!!")
            let myLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
            myLabel.text = "we returned from vc 1 !!!!!"
            myLabel.textColor = UIColor.white
            self.view.addSubview(myLabel)
            
            let myProperyAnimator = UIViewPropertyAnimator.init(duration: 2.0, curve: UIViewAnimationCurve.easeIn, animations: {
                myLabel.alpha = 0.0
            })
            myProperyAnimator.startAnimation()
        }
    }
    
    @IBAction func unwindToVC2(segue:UIStoryboardSegue) {
        self.dismiss(animated: true) {
            print("here we are!!")
            let myLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
            myLabel.text = "we returned from vc 2 !!!!!"
            myLabel.textColor = UIColor.white
            self.view.addSubview(myLabel)
            
            let myProperyAnimator = UIViewPropertyAnimator.init(duration: 2.0, curve: UIViewAnimationCurve.easeIn, animations: {
                myLabel.alpha = 0.0
            })
            myProperyAnimator.startAnimation()
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




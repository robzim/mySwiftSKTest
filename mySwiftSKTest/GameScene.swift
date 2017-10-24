//
//  GameScene.swift
//  mySwiftSKTest
//
//  Created by Rob Zimmelman on 10/12/17.
//  Copyright © 2017 Rob Zimmelman. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var pictureNode : SKSpriteNode?
    private let myRandomDist = GKRandomDistribution(lowestValue: 0, highestValue: 100)
    private let myParticleSystem = SKEmitterNode(fileNamed: "MyParticle.sks")
    private let myStrokeImage = UIImage(named: "donald-trump")
    private var myPopupNode = SKNode()
    //    private var myLevelSprite = SKSpriteNode()
    private let mySoftImpactGenerator:UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.light)
    private let myMediumImpactGenerator:UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium)
    private let myHardImpactGenerator:UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.heavy)
    //
    // these impactoccurred vars are used to make sure that only one impact occurs per touch
    private var mySoftImpactOccurred = false
    private var myMediumImpactOccurred = false
    private var myHardImpactOccurred = false

    //    private let myStrokeTexture = SKTexture(imageNamed: "donald-trump")
    
    @objc func myShowCenterButtons() {
        myPopupNode.run(SKAction.fadeAlpha(to: 1.0, duration: 0.5))
        myPopupNode.enumerateChildNodes(withName: "*") { (node, stop) in
            node.isUserInteractionEnabled = false
            node.isHidden = false
        }
    }
    
    @objc func myHideCenterButtons () {
        myPopupNode.run(SKAction.fadeAlpha(to: 0.0, duration: 0.5))
        myPopupNode.enumerateChildNodes(withName: "*") { (node, stop) in
            node.isUserInteractionEnabled = true
            node.isHidden = true
        }
        
        //        myControlsStackView.isHidden = true
    }
    
    
    @objc func myNotificationResponse() {
        print("button press notification received")
        myShowCenterButtons()
    }
    
    
    
    //
    //
    //
    //
    //
    override func didMove(to view: SKView) {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myShowCenterButtons),
                                               name: NSNotification.Name(rawValue: "showCenterButtons"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myHideCenterButtons),
                                               name: NSNotification.Name(rawValue: "hideCenterButtons"),
                                               object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myNotificationResponse),
                                               name: NSNotification.Name(rawValue: "buttonpress"),
                                               object: nil)
        
        let myLongPressGR = UILongPressGestureRecognizer(target: self, action: #selector(GameScene.myLongPressRecognized))
        myLongPressGR.minimumPressDuration = 2.0
        self.view?.addGestureRecognizer(myLongPressGR)
        
        myPopupNode = self.childNode(withName: "PopupNode")!
        myHideCenterButtons()
        
        
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        let w = (self.size.width + self.size.height) * 0.02
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        if let spinnyNode = self.spinnyNode {
            spinnyNode.name = "trails"
            spinnyNode.lineWidth = 2.5
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: Data.gameScene.myFadeDuration),
                                              SKAction.fadeOut(withDuration: Data.gameScene.myFadeDuration),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    
    
    
    @objc func myLongPressRecognized() {
        print("Long Press")
        print("Fade Duration is \(Data.gameScene.myFadeDuration)")
        scene?.enumerateChildNodes(withName: "trails", using: { (node, stop) in
            node.removeFromParent()
        })
    }
    
    func touchDown(atPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.setScale(0.25)
        //            n.position = pos
        //            n.strokeColor = myRandomColor()
        //            n.fillColor = myRandomColor()
        //            self.addChild(n)
        //        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.position = pos
        //            n.strokeColor = myRandomColor()
        //            n.glowWidth = 5.0
        //            n.lineWidth = 4.0
        //            self.addChild(n)
        //            n.run(.fadeOut(withDuration: Data.gameScene.myFadeDuration))
        //        }
    }
    
    func myRandomColor() -> SKColor {
        let myR = myRandomDist.nextInt()
        let myG = myRandomDist.nextInt()
        let myB = myRandomDist.nextInt()
        let myRed = CGFloat(myR) / 100.0
        let myGreen = CGFloat(myG) / 100.0
        let myBlue = CGFloat(myB) / 100.0
        let theRandomColor = SKColor(red: myRed, green: myGreen, blue: myBlue, alpha: 1.0)
        return theRandomColor
    }
    
    func touchUp(atPoint pos : CGPoint) {
        myPopupNode.enumerateChildNodes(withName: "*", using: { (node, stop) in
            //            print("\(node.name!) Position \(node.position) TouchUp Position \(pos) ")
            if node.contains(pos) {
                print("\(node.name!) WAS HIT !!")
                //                self.myPopupNode.isHidden = true
            }
        })
        
        //        if fabs(pos.x - myPopupNode.position.x) < 200.0  && fabs(pos.y - myPopupNode.position.y) < 200.0    {
        //            print("HIT!")
        //            self.myHideCenterButtons()
        //        }
        //        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideCenterButtons"), object: self)
        
        let myLevelSprite = self.childNode(withName: "LevelMeter")
        myLevelSprite?.xScale = 0.01
        self.myHideCenterButtons()
        mySoftImpactOccurred = false
        myMediumImpactOccurred = false
        myHardImpactOccurred = false

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mySoftImpactOccurred = false
        myMediumImpactOccurred = false
        myHardImpactOccurred = false
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myLevelSprite = self.childNode(withName: "LevelMeter")
        let myFadeAndRemove = SKAction .sequence([SKAction .scale(to: 0.1, duration: 0.5), SKAction .removeFromParent()])
        for t in touches {
            myLevelSprite?.xScale = (t.force)
            self.touchMoved(toPoint: t.location(in: self))
            if Data.gameScene.my3DTouchAvailable == true {
                //                print("Force = \(t.force)")
                if t.force > 6.5 {
                    if !myHardImpactOccurred {
                        myHardImpactGenerator.impactOccurred()
                        myHardImpactOccurred = true
                    }
                }
                if t.force > 5.0 {
                    if !myMediumImpactOccurred {
                        myMediumImpactGenerator.impactOccurred()
                        let myPS = myParticleSystem?.copy() as! SKEmitterNode
                        myPS.position = t.location(in: self)
                        myPS.setScale(2.0)
                        myPS.name = "trails"
                        self.addChild(myPS)
                        myPS.run(myFadeAndRemove)
                        myMediumImpactOccurred = true
                    }
                    
                }
                if t.force > 3.0 {
                    if !mySoftImpactOccurred {
                        mySoftImpactGenerator.impactOccurred()
                        self.myShowCenterButtons()
                        mySoftImpactOccurred = true
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
}

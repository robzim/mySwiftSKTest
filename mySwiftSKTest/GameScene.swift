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
    
    static var myTestString: String?
    
    public var myTestInt: Int?
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var pictureNode : SKSpriteNode?
    private let myRandomDist = GKRandomDistribution(lowestValue: 0, highestValue: 100)
    private let myParticleSystem = SKEmitterNode(fileNamed: "MyParticle.sks")
    private let myStrokeImage = UIImage(named: "donald-trump")
    private var myPopupNode = SKNode()
    private var myLevelSprite = SKSpriteNode()
    private let mySoftImpactGenerator:UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.light)
    private let myMediumImpactGenerator:UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.medium)
    private let myHardImpactGenerator:UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.heavy)
    //
    // these impactoccurred vars are used to make sure that only one impact occurs per touch
    private var mySoftImpactOccurred = false
    private var myMediumImpactOccurred = false
    private var myHardImpactOccurred = false
    
    private var myTopButtonsView : UIView?
    private var myBottomButtonsView : UIView?
    private var myLeftButtonsView : UIView?
    private var myRightButtonsView : UIView?
    
    private var myTopButton1Label : String?
    private var myTopButton2Label : String?
    private var myTopButton3Label : String?
    private let myBottomLabels = ["BL1","BL2","BL3"]
    private let myTopLabels = ["TL1","TL2","TL3"]
    private let myLeftLabels = ["LL1","LL2","LL3"]
    private let myRightLabels = ["RL1","RL2","RL3"]
    
    @objc func myShowCenterButtons() {
        myPopupNode.run(SKAction.fadeAlpha(to: 1.0, duration: 0.5))
        myPopupNode.enumerateChildNodes(withName: "*") { (node, stop) in
            node.isUserInteractionEnabled = false
            node.isHidden = false
        }
    }
    
    @objc func myHideCenterButtons () {
        myPopupNode.run(SKAction.fadeAlpha(to: 0.0, duration: 0.1))
    }
    
    //
    override func didMove(to view: SKView) {
        
        myTopButtonsView = self.view?.viewWithTag(1212)
        myBottomButtonsView = self.view?.viewWithTag(606)
        myLeftButtonsView = self.view?.viewWithTag(909)
        myRightButtonsView = self.view?.viewWithTag(303)
        
        
        myLevelSprite = self.childNode(withName: "LevelMeter")! as! SKSpriteNode
        myLevelSprite.xScale = 0.01
        let myCustomAction = SKAction.customAction(withDuration: 0.0) {
            node, elapsedTime in
            if let node = node as? SKSpriteNode {
                node.color = .blue                            }
        }
        myLevelSprite.run(myCustomAction)
        let myLongPressGR = UILongPressGestureRecognizer(target: self, action: #selector(GameScene.myLongPressRecognized))
        myLongPressGR.minimumPressDuration = 2.0
        self.view?.addGestureRecognizer(myLongPressGR)
        
        myPopupNode = self.childNode(withName: "PopupNode")!
        myHideCenterButtons()
        
    }
    
    
    
    
    
    @objc func myLongPressRecognized() {
        print("Long Press")
        print("Fade Duration is \(Data.gameScene.myFadeDuration)")
        scene?.enumerateChildNodes(withName: "trails", using: { (node, stop) in
            node.removeFromParent()
        })
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
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
        myLevelSprite = self.childNode(withName: "LevelMeter")! as! SKSpriteNode
        myLevelSprite.xScale = 0.01
        
        myPopupNode.enumerateChildNodes(withName: "*", using: { (node, stop) in
            if node.contains(pos) {
                
                if node.name != "myHideSprite" {
                    let myColorNode = SKShapeNode(circleOfRadius: 50.0)
                    myColorNode.fillColor = .red
                    myColorNode.position = node.position
                    myColorNode.alpha = 0.25
                    self.myPopupNode.addChild(myColorNode)
                    myColorNode.run(SKAction.sequence([
                        SKAction.wait(forDuration: 0.05),
                        SKAction.removeFromParent()
                        ]))
                }
                
                //
                //
                //  crashes to the line below when we land on the centersprite as it is still fading out
                //
                //
                print("\(node.name!) WAS HIT !!")
                switch node.name! {
                case "myCenterSprite" :
                    self.myPopupNode.removeAllActions()
                    let myPopupShrinkAndFadeAction = SKAction.group([
                        SKAction.scale(to: 0.01, duration: 0.05),
                        SKAction.fadeAlpha(to: 0.0, duration: 0.05),
                        ])
                    self.myPopupNode.run(myPopupShrinkAndFadeAction)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideAllButtons"), object: self)
                case "myUpSprite" :
                    for i in [0,1,2] {
                        let myTempButton = self.myTopButtonsView?.subviews[i] as! UIButton
                        myTempButton.setTitle(self.myTopLabels[i], for: UIControlState.normal)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTopButtons"), object: self)
                case "myDownSprite" :
                    for i in [0,1,2] {
                        let myTempButton = self.myBottomButtonsView?.subviews[i] as! UIButton
                        myTempButton.setTitle(self.myBottomLabels[i], for: UIControlState.normal)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBottomButtons"), object: self)
                case "myRightSprite" :
                    for i in [0,1,2] {
                        let myTempButton = self.myRightButtonsView?.subviews[i] as! UIButton
                        myTempButton.setTitle(self.myRightLabels[i], for: UIControlState.normal)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showRightButtons"), object: self)
                case "myLeftSprite" :
//                    for i in [0,1,2] {
//                        let myTempButton = self.myLeftButtonsView?.subviews[i] as! UIButton
//                        myTempButton.setTitle(self.myLeftLabels[i], for: UIControlState.normal)
//                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showLeftButtons"), object: self)
                case "myHideSprite" :
                    self.myHideCenterButtons()
                default :
                    print("NOT FOUND")
                }
            }
            
        })
        
        myLevelSprite.xScale = 0.01
        mySoftImpactOccurred = false
        myMediumImpactOccurred = false
        myHardImpactOccurred = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myPopupNode.setScale(1.0)
        mySoftImpactOccurred = false
        myMediumImpactOccurred = false
        myHardImpactOccurred = false
        for t in touches {
            myLevelSprite.xScale = t.force
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myFadeAndRemove = SKAction .sequence([SKAction .scale(to: 0.1, duration: 0.25), SKAction .removeFromParent()])
        for t in touches {
            let myPS = myParticleSystem?.copy() as! SKEmitterNode
            myPS.position = t.location(in: self)
            myPS.setScale(t.force)
            myPS.name = "trails"
            self.addChild(myPS)
            myPS.run(myFadeAndRemove)
            myLevelSprite.xScale = t.force
            self.touchMoved(toPoint: t.location(in: self))
            if Data.gameScene.my3DTouchAvailable == true {
                switch t.force {
                case 1.0..<3.0:
                    myLevelSprite.color = .orange
                    if !mySoftImpactOccurred {
                        mySoftImpactGenerator.impactOccurred()
                        self.myShowCenterButtons()
                        mySoftImpactOccurred = true
                    }
                case 3.0..<5.0:
                    myLevelSprite.color = .yellow
                    myLevelSprite.removeAllActions()
                    if !myMediumImpactOccurred {
                        myMediumImpactGenerator.impactOccurred()
                        myMediumImpactOccurred = true
                    }
                case 5.0..<100.5:
                    myLevelSprite.color = .white
                    if !myHardImpactOccurred {
                        myHardImpactGenerator.impactOccurred()
                        myHardImpactOccurred = true
                    }
                default:
                    return
                }
                
                
                //                if t.force > 5.5 {
                //                    myLevelSprite.color = .white
                //                    if !myHardImpactOccurred {
                //                        myHardImpactGenerator.impactOccurred()
                //                        myHardImpactOccurred = true
                //                    }
                //                }
                //                if t.force > 3.0 {
                //                    myLevelSprite.color = .yellow
                //                    myLevelSprite.removeAllActions()
                //                    if !myMediumImpactOccurred {
                //                        myMediumImpactGenerator.impactOccurred()
                //                        myMediumImpactOccurred = true
                //                    }
                //                }
                //                if t.force > 2.0 {
                //                    myLevelSprite.color = .orange
                //                    if !mySoftImpactOccurred {
                //                        mySoftImpactGenerator.impactOccurred()
                //                        self.myShowCenterButtons()
                //                        mySoftImpactOccurred = true
                //                    }
                //                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myCustomAction = SKAction.customAction(withDuration: 0.0) {
            node, elapsedTime in
            if let node = node as? SKSpriteNode {
                node.color = .blue                            }
        }
        myLevelSprite.run(myCustomAction)
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    //    }
    
    
}

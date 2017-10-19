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
//    private var myLevelSprite = SKSpriteNode()

    
//    private let myStrokeTexture = SKTexture(imageNamed: "donald-trump")
    
    
    override func didMove(to view: SKView) {
        //        NotificationCenter .default.addObserver(self, selector: #selector(myChangeFadeValue), name: NSNotification.Name(rawValue: "changeFadeValue"), object: Any?.self)
        let myLongPressGR = UILongPressGestureRecognizer(target: self, action: #selector(GameScene.myLongPressRecognized))
        myLongPressGR.minimumPressDuration = 2.0
        self.view?.addGestureRecognizer(myLongPressGR)
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
    
//    @objc func myChangeFadeValue() {
//        print("in myChngeFadeValue")
//    }
    
    
    @objc func myLongPressRecognized() {
        print("Long Press")
        print("Fade Duration is \(Data.gameScene.myFadeDuration)")
        scene?.enumerateChildNodes(withName: "trails", using: { (node, stop) in
            node.removeFromParent()
        })
    }

    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            //            let myRandomDist = GKRandomDistribution(lowestValue: 0, highestValue: 100)
            let myR = myRandomDist.nextInt()
            let myG = myRandomDist.nextInt()
            let myB = myRandomDist.nextInt()
            let myRed = CGFloat(myR) / 100.0
            let myGreen = CGFloat(myG) / 100.0
            let myBlue = CGFloat(myB) / 100.0
            let myRandomColor = SKColor(red: myRed, green: myGreen, blue: myBlue, alpha: 1.0)
            n.setScale(0.25)
            n.position = pos
            n.strokeColor = myRandomColor
            n.fillColor = myRandomColor
            self.addChild(n)
            }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            //            let myRandomDist = GKRandomDistribution(lowestValue: 0, highestValue: 100)
            let myR = myRandomDist.nextInt()
            let myG = myRandomDist.nextInt()
            let myB = myRandomDist.nextInt()
            let myRed = CGFloat(myR) / 100.0
            let myGreen = CGFloat(myG) / 100.0
            let myBlue = CGFloat(myB) / 100.0
            let myRandomColor = SKColor(red: myRed, green: myGreen, blue: myBlue, alpha: 1.0)
            n.strokeColor = myRandomColor
            n.glowWidth = 5.0
            n.lineWidth = 4.0
//            n.strokeTexture = myStrokeTexture
            self.addChild(n)
            n.run(.fadeOut(withDuration: Data.gameScene.myFadeDuration))
        }
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
        let myLevelSprite = self.childNode(withName: "LevelMeter")
        myLevelSprite?.xScale = 0.01
        let myStrokeTexture = SKTexture(imageNamed: "hillary-clinton.png")
        let myTextureNode = SKSpriteNode(texture: myStrokeTexture)
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            myTextureNode.position = pos
            myTextureNode.scale(to: CGSize(width: 50.0, height: 50.0))
            self.addChild(myTextureNode)
            n.position = pos
            self.addChild(n)
            let mySpinAction = SKAction.rotate(byAngle: 360, duration: 2.0)
            let myScaleDownAction = SKAction.scale(to: 0.01, duration: 2.0)
            let mySpinAndScaleDownAction = SKAction.group([mySpinAction,myScaleDownAction])
            let myFadeOutAction = SKAction.fadeOut(withDuration: 0.5)
            n.run(SKAction.sequence([mySpinAndScaleDownAction,myFadeOutAction]))
            myTextureNode.run(SKAction.sequence([SKAction .wait(forDuration: 0.25), SKAction .removeFromParent()]))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.rotate(toAngle: 0.0, duration: 0.5))
        }
        
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
                print("Force = \(t.force)")
                if t.force > 2.0 {
                    let myPS = myParticleSystem?.copy() as! SKEmitterNode
                    myPS.position = t.location(in: self)
                    myPS.setScale(2.0)
                    myPS.name = "trails"
                    self.addChild(myPS)
                    myPS.run(myFadeAndRemove)
                }
                if t.force > 4.0 {
                    let myPS = myParticleSystem?.copy() as! SKEmitterNode
                    myPS.position = t.location(in: self)
                    myPS.setScale(10.0)
                    myPS.particleColor = myRandomColor()
                    myPS.name = "trails"
                    self.addChild(myPS)
                    myPS.run(myFadeAndRemove)
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
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

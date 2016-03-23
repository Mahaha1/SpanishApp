

import Foundation
import UIKit
import SpriteKit
import AVFoundation

class Scene03: SeasonsSceneBase {
    
    // MARK: -
    // MARK: Scene Setup and Initialize
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        playBackgroundMusic("pg03_bgMusic.mp3")
        
        /* add background image */
        
        let background: SKSpriteNode? = SKSpriteNode(imageNamed:"bg_pg03", normalMapped:false)
        background?.anchorPoint = .zero
        background?.position = .zero
        background?.size = view.bounds.size
        
        addChild(background!)
        
        /* additional setup */
        
        
        setUpFooter()
        
        
        
        
        setUpMainScene()
    }
    
    // MARK: -
    // MARK: Standard Scene Setup
    
        
    func readText() {
        if (actionForKey("readText") == nil) {
            let readPause = SKAction.waitForDuration(0.25)
            let readText = SKAction.playSoundFileNamed("pg03.wav", waitForCompletion: false)
            
            let readSequence = SKAction.sequence([readPause, readText])
            
            runAction(readSequence, withKey:"readText")
        } else {
            removeActionForKey("readText")
        }
    }
    
    // MARK: -
    // MARK: Additional Scene Setup (sprites and such)
    
    func setUpMainScene() {
        /* add the kid and the cat */
        
        //let cat = SKSpriteNode(imageNamed: "pg03_kid_cat")
        //cat.anchorPoint = .zero
        //cat.position = CGPoint(x: size.width/2 - 25, y: 84)
        
        //addChild(cat)
        
        /* add Snowflakes */
        
        let duration = 1.25 // determines how often to create snowflakes

        runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock({
            self.spawnSnowflake()
        }), SKAction.waitForDuration(duration)])))
     }
    
    func spawnSnowflake() {
        // here you can even add physics and a shake motion too
       
        let randomNumber =  Int.random(3) + 1
        let duration = CGFloat.random() * (21 - 5) + 5
        
        let snowflakeImageName = "snowfall0\(randomNumber)"
        let snowflake = SKSpriteNode(imageNamed: snowflakeImageName)
        snowflake.name = "snowflake"
        
        snowflake.position = CGPoint(x: CGFloat.random() * size.height, y: size.height + size.height/2)
        addChild(snowflake)
        
        let actionMove = SKAction.moveTo(CGPoint(x: snowflake.position.x + 100, y: -snowflake.size.height/2), duration: NSTimeInterval(duration))
        
        let actionRemove = SKAction.removeFromParent()
        snowflake.runAction(SKAction.sequence([actionMove, actionRemove]))
    }
    
    func checkCollisions() {
        enumerateChildNodesWithName("snowflake") { (node: SKNode, stop: UnsafeMutablePointer<ObjCBool>) in
            let snowflake = node as! SKSpriteNode
            let footerFrameWithPadding = CGRectInset(self.footer.frame, -25, -25)
            
            if CGRectIntersectsRect(snowflake.frame, footerFrameWithPadding) {
                snowflake.removeFromParent()
            }
        }
    }
    
    override func getNextScene() -> SKScene? {
        return Scene04(size: size)
    }
    
    override func getPreviousScene() -> SKScene? {
        return Scene02(size: size)
    }
    
    // MARK: -
    // MARK: Game Loop
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        checkCollisions()
    }
}
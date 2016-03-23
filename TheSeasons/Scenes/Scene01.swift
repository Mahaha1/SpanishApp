

import Foundation
import UIKit
import SpriteKit
import AVFoundation

class Scene01: SeasonsSceneBase {
  private var kid = SKSpriteNode(imageNamed: "pg01_kid")
  private var hat = SKSpriteNode(imageNamed: "pg01_kid_hat")
  private var touchingHat = false
  private var touchPoint: CGPoint?

  // MARK: -
  // MARK: Scene Setup and Initialize

  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)

    /* set up Sound */
    playBackgroundMusic("pg01_bgMusic.mp3")

    /* add background image */

    let background: SKSpriteNode? = SKSpriteNode(imageNamed:"bg_pg01")
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
    if actionForKey("readText") == nil {
      let readPause = SKAction.waitForDuration(0.25)
      let readText = SKAction.playSoundFileNamed("pg01.wav", waitForCompletion: true)

      let readSequence = SKAction.sequence([readPause, readText])

      runAction(readSequence, withKey:"readText")
    } else {
      removeActionForKey("readText")
    }
  }

  // MARK: -
  // MARK: Additional Scene Setup (sprites and such)

  func setUpMainScene() {
    setUpMainCharacter()
    setUpHat()
  }

  func setUpMainCharacter() {
    kid.anchorPoint = .zero
    kid.position = CGPoint(x: self.size.width/2 - 245, y: 45)
    kid.zPosition = 1

    addChild(kid)
    setUpMainCharacterAnimation()
  }

  func setUpMainCharacterAnimation() {
    var textures = [SKTexture]()

    for i in 0..<3 {
      //let textureName = "pg01_kid0\(i)"
        let textureName = "pg01_kid"
      let texture = SKTexture(imageNamed: textureName)

      textures.append(texture)
    }

    // check for variable duration and see if it's actually useful
    
    
    let blink = SKAction.animateWithTextures(textures, timePerFrame: 0.25)
    let wait = SKAction.waitForDuration(4.5, withRange: 1.5)

    let mainCharacterAnimation = SKAction.sequence([blink, wait, blink, blink, wait , blink, blink])
    kid.runAction(SKAction.repeatActionForever(mainCharacterAnimation))
  }

  func setUpHat() {
    let label = SKLabelNode(fontNamed: "Thonburi-Bold")
    label.text = " Follow The Instructions"
    label.fontSize = 20.0
    label.fontColor = UIColor.yellowColor()
    label.position = CGPoint(x: 200, y: 180)

    addChild(label)

    hat.position = CGPoint(x: 150, y: 290)
    hat.physicsBody = SKPhysicsBody(rectangleOfSize: hat.size)
    hat.physicsBody?.restitution = 0.5
    hat.zPosition = 2

    addChild(hat)
  }

  // MARK: -
  // MARK: Touch Events

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    for touch in touches {
      let location = touch.locationInNode(self)

      if hat.containsPoint(location) {
        touchingHat = true
        touchPoint = location

        /* change the physics or the hat is too 'heavy' */

        hat.physicsBody?.velocity = CGVectorMake(0, 0)
        hat.physicsBody?.angularVelocity = 0
        hat.physicsBody?.affectedByGravity = false
      }
    }
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch = touches.first as? UITouch! {
      touchPoint = touch.locationInNode(self)
    }
  }

  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch = touches.first as? UITouch? where touchingHat {
      var currentPoint: CGPoint = touch!.locationInNode(self)

      if currentPoint.x >= 300 && currentPoint.x <= 550 && currentPoint.y >= 250 && currentPoint.y <= 400 {
        currentPoint.x = 390
        currentPoint.y = 390

        hat.position = currentPoint
        

        let popSound = SKAction.playSoundFileNamed("thompsonman_pop.wav", waitForCompletion: false)
        hat.runAction(popSound)
      } else {
        hat.physicsBody?.affectedByGravity = true
      }
      touchingHat = false
    }
  }

  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    touchingHat = false
    hat.physicsBody?.affectedByGravity = true
  }

  override func getNextScene() -> SKScene? {
    return Scene02(size: size)
  }
    
// function to go to back page in book - FURQAN

  override func getPreviousScene() -> SKScene? {
    return Scene00(size: size)
  }

  // MARK: -
  // MARK: Game Loop

  override func update(currentTime: CFTimeInterval) {
    if touchingHat {
      if var touchPoint = touchPoint {
        touchPoint.x.clamp(hat.size.width / 2, self.size.width - hat.size.width / 2)
        touchPoint.y.clamp(footer.size.height + hat.size.height / 2, self.size.height - hat.size.height / 2)

        hat.position = touchPoint
      }
    }
  }

}
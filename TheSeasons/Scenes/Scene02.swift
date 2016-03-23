//

import Foundation
import UIKit
import SpriteKit
import AVFoundation

class Scene02: SeasonsSceneBase {
  private var cat = SKSpriteNode(imageNamed: "pg02_cat")
  private var catSound = SKAction.playSoundFileNamed("cameronmusic_meow.wav", waitForCompletion: false)

  // MARK: -
  // MARK: Scene Setup and Initialize

  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)

    /* set up Sound */
    playBackgroundMusic("pg02_bgMusic.mp3")

    /* add background image */

    let background: SKSpriteNode? = SKSpriteNode(imageNamed:"bg_pg02", normalMapped:false)
    background?.anchorPoint = .zero
    background?.position = .zero
    background?.size = view.bounds.size

    addChild(background!)

    
    cat.anchorPoint = .zero
    cat.position = CGPoint(x: 240, y: 84)
    cat.xScale = 0.5
    cat.yScale = 0.5

    addChild(cat)

    /* make 'em meow! */

    let wait = SKAction.waitForDuration(0.86)
    let catSoundInitial = SKAction.playSoundFileNamed("thegertz_meow.wav", waitForCompletion: false)

    cat.runAction(SKAction.sequence([wait, catSoundInitial]))

    setUpText()
    setUpFooter()
  }

  // MARK: -
  // MARK: Standard Scene Setup

  func setUpText() {
   // need to find if this function can be deleted
    }

  func readText() {
    if actionForKey("readText") == nil {
      let readPause = SKAction.waitForDuration(0.25)
      let readText = SKAction.playSoundFileNamed("pg02.wav", waitForCompletion: false)

      let readSequence = SKAction.sequence([readPause, readText])

      runAction(readSequence, withKey:"readText")
    } else {
      removeActionForKey("readText")
    }

  }

  // MARK: -
  // MARK: Code For Sound & Ambiance

  func playCatSound() {
    cat.runAction(catSound)
  }

  // MARK: -
  // MARK: Touch Events

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    for touch in touches {
      let location = touch.locationInNode(self)
      if location.x >= 300 && location.x < 480 && location.y >= 100 && location.y <= 350 {
        playCatSound()
      }
    }
  }

  override func getNextScene() -> SKScene? {
    return Scene03(size: size)
  }

  override func getPreviousScene() -> SKScene? {
    return Scene01(size: size)
  }

  // MARK: -
  // MARK: Game Loop

  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}


import Foundation
import UIKit
import SpriteKit
import AVFoundation

class Scene00: SeasonsSceneBase {

  // MARK: -
  // MARK: Scene Setup and Initialize

  override func didMoveToView(view: SKView) {
    homeFooter = true

    playBackgroundMusic("title_bgMusic.mp3")

    let background = SKSpriteNode(imageNamed: "bg_title_page")
    background.anchorPoint = CGPoint(x: 0, y: 0)
    background.position = .zero
    background.size = view.bounds.size
    

    addChild(background)

    setUpBookTitle()
    setUpFooter()
  }

  // MARK: -
  // MARK: Additional Scene Setup (sprites and such)

  func setUpBookTitle() {
    let bookTitle = SKSpriteNode(imageNamed: "title_text")
    bookTitle.name = "bookTitle"

    bookTitle.position = CGPoint(x: 425, y: 900)
    addChild(bookTitle)

    let actionMoveDown = SKAction.moveToY(720, duration: 3.0)
    let actionMoveUp = SKAction.moveToY(740, duration: 0.25)
    let actionMoveDownFast = SKAction.moveToY(730, duration: 0.25)

    let wait = SKAction.waitForDuration(0.75)

    let showButton = SKAction.runBlock {

      let buttonStart = SKSpriteNode(imageNamed: "button_read")
      buttonStart.size = CGSizeMake(200, 100)
    
      buttonStart.name = "buttonStart"

      buttonStart.position = CGPoint(x: 425,y: 300)
      buttonStart.zPosition = 2

      self.addChild(buttonStart)

      buttonStart.runAction(SKAction.playSoundFileNamed("thompsonman_pop.wav", waitForCompletion: false))
    }

    bookTitle.runAction(SKAction.sequence([actionMoveDown, actionMoveUp, actionMoveDownFast, wait, showButton]))
  }

  // MARK: -
  // MARK: Touch Events

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    // Make sure the start button has been added.
    if let startButton = childNodeWithName("buttonStart") {

      /* Called when a touch begins */
      for touch in touches {
        let location = touch.locationInNode(self)

        if startButton.containsPoint(location) {
          goToScene(Scene01(size: size))
        }
      }
    }
  }

  // MARK: -
  // MARK: Game Loop

  override func update(currentTime: CFTimeInterval) {


  }
}
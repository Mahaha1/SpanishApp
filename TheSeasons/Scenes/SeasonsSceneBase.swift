
//

import SpriteKit
import AVFoundation

class SeasonsSceneBase: SKScene {
  private var backgroundMusicPlayer: AVAudioPlayer?
  private var btnSound = SKSpriteNode(imageNamed: "button_sound_on")
  private var soundOff: Bool
  var homeFooter = false

  var footer = SKSpriteNode(imageNamed: "footer")
  var btnLeft = SKSpriteNode(imageNamed: "button_left")
  var btnRight = SKSpriteNode(imageNamed: "button_right")

  override init(size: CGSize) {

    /* Check the sound preferences */
    soundOff = NSUserDefaults.standardUserDefaults().boolForKey("pref_sound")

    super.init(size: size)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: -
  // MARK: Code For Sound & Ambiance

  func playBackgroundMusic(filename: String) {
    var error: NSError?
    let backgroundMusicURL = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    do {
      backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: backgroundMusicURL!)
    } catch let error1 as NSError {
      error = error1
      backgroundMusicPlayer = nil
    }
    backgroundMusicPlayer?.numberOfLoops = -1
    backgroundMusicPlayer?.volume = 0.50
    backgroundMusicPlayer?.prepareToPlay()

  }

  func showSoundButtonForTogglePosition(togglePosition: Bool) {
    if togglePosition {
      let action = SKAction.setTexture(SKTexture(imageNamed: "button_sound_on"))
      btnSound.runAction(action)

      soundOff = false
      NSUserDefaults.standardUserDefaults().setBool(false, forKey: "pref_sound")
      NSUserDefaults.standardUserDefaults().synchronize()

      backgroundMusicPlayer?.play()
    } else {
      let action = SKAction.setTexture(SKTexture(imageNamed: "button_sound_off"))
      btnSound.runAction(action)

      soundOff = true
      NSUserDefaults.standardUserDefaults().setBool(true, forKey: "pref_sound")
      NSUserDefaults.standardUserDefaults().synchronize()

      backgroundMusicPlayer?.stop()
    }
  }

  func setUpFooter() {

    if !homeFooter {
      /* add the footer */
      footer.position = CGPoint(x: self.size.width/2, y: 38)
      btnRight.zPosition = 1
      addChild(footer)
      physicsBody = SKPhysicsBody(edgeLoopFromRect: footer.frame)
    }

    /* add the right button if there is a next scene */
    if getNextScene() != nil {
      btnRight.position = CGPoint(x: self.size.width/2 + 470, y: 38)
      btnRight.zPosition = 1
      addChild(btnRight)
    }

    /* add the left button if there is a previous scene */
    if getPreviousScene() != nil {
      btnLeft.position = CGPoint(x: self.size.width/2 + 400, y: 38)
      btnLeft.zPosition = 1
      addChild(btnLeft)
    }

    /* add the sound button */
    btnSound.zPosition = 1

    if soundOff {
      let action = SKAction.setTexture(SKTexture(imageNamed: "button_sound_off"))
      btnSound.runAction(action)

      backgroundMusicPlayer?.stop()
    } else {
      let action = SKAction.setTexture(SKTexture(imageNamed: "button_sound_on"))
      btnSound.runAction(action)

      backgroundMusicPlayer?.play()
    }

    if homeFooter {
      // Positions the sound button all the way to the right.
      btnSound.position = CGPoint(x: 980, y: 38)
    } else {
      btnSound.position = CGPoint(x: self.size.width/2 + 330, y: 38)
    }
    addChild(btnSound)
  }

  // MARK: -
  // MARK: Touch Events

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    for touch in touches {
      let location = touch.locationInNode(self)

      if btnSound.containsPoint(location) {
        showSoundButtonForTogglePosition(soundOff)
      } else if actionForKey("readText") != nil { // do not turn page if reading
        return
      } else if btnRight.containsPoint(location) {
        // Right button goes to the next scene.
        if let nextScene = getNextScene() {
          goToScene(nextScene)
        }
      } else if btnLeft.containsPoint(location) {
        // Left button goes to the previous scene
        if let previousScene = getPreviousScene() {
          goToScene(previousScene)
        }
      } else if location.x >= 29 && location.x <= 285 && location.y >= 6 && location.y <= 68 {
        // Go back to the home scene.
        goToScene(Scene00(size: size))
      }
    }
  }

  func goToScene(scene: SKScene) {
    backgroundMusicPlayer?.stop()

    let sceneTransition = SKTransition.fadeWithColor(UIColor.darkGrayColor(), duration: 1)
    self.view?.presentScene(scene, transition: sceneTransition)
  }

  func getNextScene() -> SKScene? {
    // Return the next scene in subclasses
    return nil
  }

  func getPreviousScene() -> SKScene? {
    // Return the previous scene in subclasses
    return nil
  }
}
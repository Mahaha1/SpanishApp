
import Foundation
import UIKit
import SpriteKit
import AVFoundation

class Scene04: SeasonsSceneBase {
    
    // MARK: -
    // MARK: Scene Setup and Initialize
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        /* set up Sound */
        playBackgroundMusic("title_bgMusic.mp3")
        
        /* add background image */
        
        let background: SKSpriteNode? = SKSpriteNode(imageNamed:"to_be_continued", normalMapped:false)
        background?.anchorPoint = .zero
        background?.position = .zero
        
        addChild(background!)
        
        /* additional setup */
        
        setUpFooter()
    }
    
    override func getNextScene() -> SKScene? {
        return Scene05(size: size)
    }
    
    
    override func getPreviousScene() -> SKScene? {
        return Scene03(size: size)
    }
    
    

    
    // MARK: -
    // MARK: Game Loop
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
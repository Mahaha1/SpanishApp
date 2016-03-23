
import Foundation
import UIKit
import SpriteKit
import AVFoundation

class Scene05: SeasonsSceneBase, UITextFieldDelegate {
    
    // MARK: -
    // MARK: Scene Setup and Initialize
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        /* set up Sound */
        playBackgroundMusic("title_bgMusic.mp3")
        
        /* add background image */
        
        let background: SKSpriteNode? = SKSpriteNode(imageNamed:"bg_pg03", normalMapped:false)
        background?.anchorPoint = .zero
        background?.position = .zero
        background?.size = view.bounds.size
        
        addChild(background!)
        
                
    
        
        
        
        
        /* additional setup */
        
        setUpFooter()
    }
    
    override func getPreviousScene() -> SKScene? {
        return Scene04(size: size)
    }
    
    
    // MARK: -
    // MARK: Game Loop
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
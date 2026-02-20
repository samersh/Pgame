

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameManager: GameManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameManager = GameManager(gameViewController: self)
        
        if let view = self.view as! SKView? {
            
            if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                scene.scaleMode = .aspectFill
                scene.gameManager = gameManager
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

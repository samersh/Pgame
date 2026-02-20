import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameManager: GameManager!
    var skView: SKView!

    override func loadView() {
        // Create SKView as the main view
        skView = SKView()
        self.view = skView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameManager = GameManager(gameViewController: self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Only present scene once we have proper bounds
        if skView.scene == nil && view.bounds.size != .zero {
            // Create scene programmatically with the view's size
            let scene = MainMenuScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            scene.gameManager = gameManager

            skView.presentScene(scene)
            skView.ignoresSiblingOrder = true

            #if DEBUG
            skView.showsFPS = true
            skView.showsNodeCount = true
            #endif
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

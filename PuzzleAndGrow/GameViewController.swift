import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameManager: GameManager!
    var skView: SKView!
    private var hasStartedGame = false

    override func loadView() {
        // Create SKView as the main view
        skView = SKView()
        skView.backgroundColor = .white
        self.view = skView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gameManager = GameManager(gameViewController: self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Start the game once we have proper bounds
        if !hasStartedGame && view.bounds.size.width > 0 && view.bounds.size.height > 0 {
            hasStartedGame = true

            #if DEBUG
            skView.showsFPS = true
            skView.showsNodeCount = true
            #endif
            skView.ignoresSiblingOrder = true

            // Now start the game - this will present the MainMenuScene
            gameManager.startGame()
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

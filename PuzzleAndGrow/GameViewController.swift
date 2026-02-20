import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameManager: GameManager!
    var skView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("GameViewController viewDidLoad")

        // Create SKView
        skView = SKView(frame: view.bounds)
        skView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(skView)

        // Debug settings
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true

        // Create GameManager
        gameManager = GameManager(gameViewController: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("GameViewController viewDidAppear - skView frame: \(skView.frame)")

        // Present the main menu scene directly
        if skView.scene == nil {
            let scene = MainMenuScene(size: skView.bounds.size)
            scene.scaleMode = .aspectFill
            scene.gameManager = gameManager
            print("Presenting scene with size: \(scene.size)")
            skView.presentScene(scene)
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

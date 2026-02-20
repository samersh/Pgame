import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameManager: GameManager!
    var skView: SKView!
    private var hasStartedGame = false

    override func loadView() {
        print("GameViewController loadView")
        // Create SKView as the main view
        skView = SKView()
        skView.backgroundColor = SKColor(red: 245/255, green: 245/255, blue: 235/255, alpha: 1.0)
        self.view = skView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("GameViewController viewDidLoad")
        gameManager = GameManager(gameViewController: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("GameViewController viewWillAppear - bounds: \(view.bounds)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("GameViewController viewDidAppear - bounds: \(view.bounds)")

        // Start game here to ensure view is fully laid out
        if !hasStartedGame && view.bounds.size.width > 0 && view.bounds.size.height > 0 {
            hasStartedGame = true

            #if DEBUG
            skView.showsFPS = true
            skView.showsNodeCount = true
            #endif
            skView.ignoresSiblingOrder = true

            print("Starting game with bounds: \(view.bounds)")
            gameManager.startGame()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("GameViewController viewDidLayoutSubviews - bounds: \(view.bounds)")
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

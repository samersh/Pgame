import GameplayKit
import SpriteKit

class MainMenuState: GameState {
    override func didEnter(from previousState: GKState?) {
        print("MainMenuState didEnter")

        guard let viewController = gameManager.gameViewController else {
            print("ERROR: gameViewController is nil")
            return
        }

        guard let view = viewController.skView else {
            print("ERROR: skView is nil")
            return
        }

        print("View bounds: \(view.bounds)")

        let scene = MainMenuScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        scene.gameManager = gameManager

        print("Presenting MainMenuScene with size: \(scene.size)")
        view.presentScene(scene)
    }
}

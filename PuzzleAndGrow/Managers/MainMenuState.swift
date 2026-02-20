import GameplayKit
import SpriteKit

class MainMenuState: GameState {
    override func didEnter(from previousState: GKState?) {
        guard let view = gameManager.gameViewController?.skView else { return }

        let scene = MainMenuScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        scene.gameManager = gameManager
        view.presentScene(scene)
    }
}

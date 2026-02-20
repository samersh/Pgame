import GameplayKit
import SpriteKit

class PuzzleState: GameState {
    override func didEnter(from previousState: GKState?) {
        guard let view = gameManager.gameViewController?.skView else { return }

        let scene = PuzzleScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        scene.gameManager = gameManager
        view.presentScene(scene)
    }
}


import GameplayKit

class PuzzleState: GameState {
    override func didEnter(from previousState: GKState?) {
        if let view = gameManager.gameViewController?.view as? SKView {
            if let scene = PuzzleScene(fileNamed: "PuzzleScene") {
                scene.scaleMode = .aspectFill
                scene.gameManager = gameManager
                view.presentScene(scene)
            }
        }
    }
}

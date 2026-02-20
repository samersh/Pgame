
import GameplayKit

class GardenState: GameState {
    override func didEnter(from previousState: GKState?) {
        if let view = gameManager.gameViewController?.view as? SKView {
            if let scene = GardenScene(fileNamed: "GardenScene") {
                scene.scaleMode = .aspectFill
                scene.gameManager = gameManager
                view.presentScene(scene)
            }
        }
    }
}


import GameplayKit

class MainMenuState: GameState {
    override func didEnter(from previousState: GKState?) {
        if let view = gameManager.gameViewController?.view as? SKView {
            if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                scene.scaleMode = .aspectFill
                scene.gameManager = gameManager
                view.presentScene(scene)
            }
        }
    }
}

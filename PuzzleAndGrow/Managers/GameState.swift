
import GameplayKit

class GameState: GKState {
    unowned let gameManager: GameManager

    init(gameManager: GameManager) {
        self.gameManager = gameManager
        super.init()
    }
}

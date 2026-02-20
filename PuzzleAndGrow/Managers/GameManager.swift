
import GameplayKit

class GameManager {
    
    weak var gameViewController: GameViewController?
    var zenCoins: Int = 0
    
    lazy var stateMachine: GKStateMachine = {
        return GKStateMachine(states: [
            MainMenuState(gameManager: self),
            PuzzleState(gameManager: self),
            GardenState(gameManager: self)
        ])
    }()
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
        stateMachine.enter(MainMenuState.self)
    }
    
    func addZenCoins(_ amount: Int) {
        zenCoins += amount
    }
}

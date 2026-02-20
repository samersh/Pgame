
import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {

    var gameManager: GameManager!

    override func didMove(to view: SKView) {
        setupScene()
    }

    private func setupScene() {
        backgroundColor = .white

        let playButton = SKLabelNode(text: "Play")
        playButton.name = "play_button"
        playButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        playButton.fontColor = .black
        addChild(playButton)
        
        let gardenButton = SKLabelNode(text: "Garden")
        gardenButton.name = "garden_button"
        gardenButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 100)
        gardenButton.fontColor = .black
        addChild(gardenButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)

        if touchedNode.name == "play_button" {
            gameManager.stateMachine.enter(PuzzleState.self)
        } else if touchedNode.name == "garden_button" {
            gameManager.stateMachine.enter(GardenState.self)
        }
    }
}

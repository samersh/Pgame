import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {

    var gameManager: GameManager!

    // Modern Zen color palette
    let backgroundColor_zen = SKColor(red: 245/255, green: 245/255, blue: 235/255, alpha: 1.0) // Soft cream
    let primaryColor = SKColor(red: 107/255, green: 142/255, blue: 107/255, alpha: 1.0) // Sage green
    let accentColor = SKColor(red: 255/255, green: 183/255, blue: 197/255, alpha: 1.0) // Cherry blossom pink

    override func didMove(to view: SKView) {
        print("MainMenuScene didMove - size: \(size)")
        setupScene()
    }

    private func setupScene() {
        backgroundColor = backgroundColor_zen

        // Title
        let titleLabel = SKLabelNode(fontNamed: "Avenir-Heavy")
        titleLabel.text = "Puzzle & Grow"
        titleLabel.fontSize = 42
        titleLabel.fontColor = primaryColor
        titleLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        addChild(titleLabel)

        // Subtitle
        let subtitleLabel = SKLabelNode(fontNamed: "Avenir-Light")
        subtitleLabel.text = "A Relaxing Puzzle Experience"
        subtitleLabel.fontSize = 18
        subtitleLabel.fontColor = primaryColor.withAlphaComponent(0.7)
        subtitleLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.68)
        addChild(subtitleLabel)

        // Play Button
        let playButton = createButton(text: "Play", name: "play_button")
        playButton.position = CGPoint(x: size.width / 2, y: size.height * 0.45)
        addChild(playButton)

        // Garden Button
        let gardenButton = createButton(text: "Garden", name: "garden_button")
        gardenButton.position = CGPoint(x: size.width / 2, y: size.height * 0.32)
        addChild(gardenButton)

        // Zen Coins display
        let coinsLabel = SKLabelNode(fontNamed: "Avenir-Medium")
        coinsLabel.text = "🪙 \(gameManager?.zenCoins ?? 0) Zen Coins"
        coinsLabel.fontSize = 20
        coinsLabel.fontColor = primaryColor
        coinsLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.15)
        coinsLabel.name = "coins_label"
        addChild(coinsLabel)
    }

    private func createButton(text: String, name: String) -> SKNode {
        let container = SKNode()
        container.name = name

        // Button background
        let buttonBg = SKShapeNode(rectOf: CGSize(width: 200, height: 60), cornerRadius: 30)
        buttonBg.fillColor = primaryColor
        buttonBg.strokeColor = .clear
        buttonBg.name = name
        container.addChild(buttonBg)

        // Button label
        let label = SKLabelNode(fontNamed: "Avenir-Heavy")
        label.text = text
        label.fontSize = 24
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.name = name
        container.addChild(label)

        return container
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)

        for node in touchedNodes {
            if node.name == "play_button" {
                print("Play button tapped")
                // Animate button press
                node.run(SKAction.sequence([
                    SKAction.scale(to: 0.95, duration: 0.1),
                    SKAction.scale(to: 1.0, duration: 0.1),
                    SKAction.run {
                        self.gameManager.stateMachine.enter(PuzzleState.self)
                    }
                ]))
                return
            } else if node.name == "garden_button" {
                print("Garden button tapped")
                node.run(SKAction.sequence([
                    SKAction.scale(to: 0.95, duration: 0.1),
                    SKAction.scale(to: 1.0, duration: 0.1),
                    SKAction.run {
                        self.gameManager.stateMachine.enter(GardenState.self)
                    }
                ]))
                return
            }
        }
    }
}

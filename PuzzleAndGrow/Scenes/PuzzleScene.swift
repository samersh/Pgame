
import SpriteKit
import GameplayKit

class PuzzleScene: SKScene {

    var gameManager: GameManager!

    private var vials: [Vial] = []
    private var selectedVial: Vial?

    private let colors: [SKColor] = [.red, .green, .blue, .yellow]

    override func didMove(to view: SKView) {
        setupScene()
        setupVials()
    }

    private func setupScene() {
        backgroundColor = .white
    }

    private func setupVials() {
        let numberOfVials = 5
        let vialSize = CGSize(width: 50, height: 200)
        let spacing: CGFloat = 20

        let totalWidth = CGFloat(numberOfVials) * vialSize.width + CGFloat(numberOfVials - 1) * spacing
        let startX = (size.width - totalWidth) / 2

        for i in 0..<numberOfVials {
            let vial = Vial(color: .lightGray, size: vialSize)
            vial.position = CGPoint(x: startX + CGFloat(i) * (vialSize.width + spacing), y: size.height / 2)
            addChild(vial)
            vials.append(vial)
        }

        // Distribute colors
        var colorPool = colors + colors + colors + colors 
        colorPool.shuffle()

        for vial in vials {
            for _ in 0..<vial.maxCapacity {
                if !colorPool.isEmpty {
                    let color = colorPool.removeFirst()
                    vial.colors.append(color)
                }
            }
        }
        
        // leave one vial empty
        vials.last?.colors.removeAll()

        drawVials()
    }

    private func drawVials() {
        for vial in vials {
            vial.removeAllChildren()
            for (i, color) in vial.colors.enumerated() {
                let colorNode = SKSpriteNode(color: color, size: CGSize(width: vial.size.width - 10, height: (vial.size.height - 20) / CGFloat(vial.maxCapacity)))
                colorNode.position = CGPoint(x: 0, y: -vial.size.height/2 + colorNode.size.height/2 + CGFloat(i) * colorNode.size.height)
                vial.addChild(colorNode)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if let touchedNode = atPoint(location) as? Vial {
            if selectedVial == nil {
                selectedVial = touchedNode
                // Add a visual indicator for selection
                selectedVial?.run(SKAction.scale(to: 1.1, duration: 0.1))
            } else {
                if selectedVial == touchedNode {
                    // Deselect if the same vial is tapped again
                    selectedVial?.run(SKAction.scale(to: 1.0, duration: 0.1))
                    selectedVial = nil
                } else {
                    // Try to pour
                    pour(from: selectedVial!, to: touchedNode)
                    selectedVial?.run(SKAction.scale(to: 1.0, duration: 0.1))
                    selectedVial = nil
                }
            }
        }
    }

    private func pour(from sourceVial: Vial, to destinationVial: Vial) {
        guard let topColor = sourceVial.colors.last else { return } // Source is empty

        if destinationVial.colors.count < destinationVial.maxCapacity {
            if destinationVial.colors.isEmpty || destinationVial.colors.last == topColor {
                sourceVial.colors.removeLast()
                destinationVial.colors.append(topColor)
                drawVials()
                checkWinCondition()
            }
        }
    }

    private func checkWinCondition() {
        var sortedVials = 0
        for vial in vials {
            if vial.colors.isEmpty || (vial.colors.count == vial.maxCapacity && Set(vial.colors).count == 1) {
                sortedVials += 1
            }
        }

        if sortedVials == vials.count {
            gameManager.addZenCoins(10)
            let winLabel = SKLabelNode(text: "You Win!")
            winLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 + 200)
            winLabel.fontColor = .black
            winLabel.fontSize = 40
            addChild(winLabel)
            
            let action = SKAction.sequence([
                SKAction.wait(forDuration: 2.0),
                SKAction.run {
                    self.gameManager.stateMachine.enter(GardenState.self)
                }
            ])
            run(action)
        }
    }
}

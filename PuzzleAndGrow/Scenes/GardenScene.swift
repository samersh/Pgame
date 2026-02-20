
import SpriteKit
import GameplayKit

class GardenScene: SKScene {

    var gameManager: GameManager!

    private var shopNode: SKSpriteNode!
    private var inventory: [SKSpriteNode] = []
    private var selectedItem: SKSpriteNode?
    private var zenCoinsLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        setupScene()
        setupShop()
        setupUI()
    }

    private func setupScene() {
        backgroundColor = SKColor(red: 0.96, green: 0.94, blue: 0.88, alpha: 1.0)
    }

    private func setupUI() {
        zenCoinsLabel = SKLabelNode(text: "Zen Coins: \(gameManager.zenCoins)")
        zenCoinsLabel.position = CGPoint(x: 100, y: size.height - 50)
        zenCoinsLabel.fontColor = .black
        addChild(zenCoinsLabel)
        
        let watchAdButton = SKLabelNode(text: "Watch Ad for Coins")
        watchAdButton.name = "watch_ad_button"
        watchAdButton.position = CGPoint(x: size.width - 150, y: size.height - 50)
        watchAdButton.fontColor = .black
        addChild(watchAdButton)
    }

    private func setupShop() {
        shopNode = SKSpriteNode(color: .lightGray, size: CGSize(width: size.width, height: 150))
        shopNode.position = CGPoint(x: size.width / 2, y: shopNode.size.height / 2)
        addChild(shopNode)

        let plantButton = SKSpriteNode(color: .green, size: CGSize(width: 80, height: 80))
        plantButton.name = "buy_plant"
        plantButton.position = CGPoint(x: -100, y: 0)
        shopNode.addChild(plantButton)

        let decorationButton = SKSpriteNode(color: .blue, size: CGSize(width: 80, height: 80))
        decorationButton.name = "buy_decoration"
        decorationButton.position = CGPoint(x: 100, y: 0)
        shopNode.addChild(decorationButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        if let touchedNode = atPoint(location) as? SKLabelNode, touchedNode.name == "watch_ad_button" {
            if let viewController = view?.window?.rootViewController {
                AdManager.shared.showRewardedAd(from: viewController) {
                    self.gameManager.addZenCoins(5)
                    self.zenCoinsLabel.text = "Zen Coins: \(self.gameManager.zenCoins)"
                }
            }
        } else if let touchedNode = atPoint(location) as? SKSpriteNode {
            if touchedNode.name?.starts(with: "buy_") == true {
                buyItem(name: touchedNode.name!)
            } else if inventory.contains(touchedNode) {
                selectedItem = touchedNode
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let selectedItem = selectedItem else { return }
        let location = touch.location(in: self)
        selectedItem.position = location
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectedItem = nil
    }

    private func buyItem(name: String) {
        let cost = 10
        if gameManager.zenCoins >= cost {
            gameManager.addZenCoins(-cost)
            zenCoinsLabel.text = "Zen Coins: \(gameManager.zenCoins)"
            
            let item: SKSpriteNode
            if name == "buy_plant" {
                item = Plant(color: .green, size: CGSize(width: 50, height: 50))
            } else {
                item = Decoration(color: .blue, size: CGSize(width: 50, height: 50))
            }

            item.position = CGPoint(x: size.width / 2, y: size.height / 2)
            addChild(item)
            inventory.append(item)
        }
    }
}

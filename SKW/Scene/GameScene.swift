import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Actors
    let oldLady = Player()
    var velocity = CGPoint.zero
    
    
    // Update Timer
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    // Special
    var isMoving = false

    override func sceneDidLoad() {
        self.physicsWorld.contactDelegate = self
        //    self.physicsWorld.gravity = CGVector(dx:0, dy: -9.8)
        //    self.physicsBody?.restitution = 0
        //    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    override func didMove(to view: SKView) {
        
        if isMoving == false {
            oldLady.animate(type: "idle")
        }
    
        //Background

        
                let background = SKSpriteNode(imageNamed: "scene1Background")
                background.position = CGPoint(x: size.width/2, y: size.height/2)
                background.size = CGSize(width: self.frame.width, height: self.frame.height)
                background.zPosition = -1
                addChild(background)
        
        //Game Plane
        GameManager.shared.setup(view: self.view!)
        
        // Player
        debugPrint( GameManager.shared.setup)
        oldLady.setup(view: self.view!)
        oldLady.zPosition = 100
        //        debugPrint("pos old lady: \(oldLady.squarePlayerPosition)")
        //        oldLady.zPosition = 1
        addChild(oldLady)
        
        
        
        //Audio
        let alarm = SKAudioNode(fileNamed: "scene1Audio")
        addChild(alarm)
        
        
        // Gestures
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeMoveUp))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view?.addGestureRecognizer(swipeUp)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeMoveRight))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view?.addGestureRecognizer(swipeRight)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeMoveDown))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view?.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeMoveLeft))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view?.addGestureRecognizer(swipeLeft)
        
    }
    @objc func swipeMoveUp() {
        isMoving = true
        debugPrint("swipeup")
        oldLady.moveUp()
        isMoving = false
    }
    @objc func swipeMoveRight() {
        isMoving = true
        debugPrint("swiperight")
        oldLady.moveRight()
        isMoving = false
    }
    @objc func swipeMoveDown() {
        isMoving = true
        debugPrint("swipedown")
        oldLady.moveDown()
        isMoving = false
    }
    @objc func swipeMoveLeft() {
        isMoving = true
        oldLady.moveLeft()
        debugPrint("swipelefy")
        isMoving = false
    }
    
    func touchDown(atPoint pos: CGPoint) {
        
    }
    func touchMoved(toPoint pos: CGPoint) {
        
    }
    func touchUp(atPoint pos: CGPoint) {
        //    stickTouchUp(pos: pos)
        //    dPadTouchUp(pos: pos)
        // Gesture Trigger
        if !isMoving{
            oldLady.attack()
        }
        isMoving = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.touchDown(atPoint: touch.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.touchMoved(toPoint: touch.location(in: self))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.touchUp(atPoint: touch.location(in: self))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // MARK: Render Loop
    override func update(_ currentTime: TimeInterval) {
        
        // If we don't have a last frame time value, this is the first frame, so delta time will be zero.
        if lastUpdateTime <= 0 { lastUpdateTime = currentTime }
        
        // Update delta time
        dt = currentTime - lastUpdateTime
        // debugPrint("\(deltaTime * 1000) milliseconds")
        
        // Set last frame time to current time
        lastUpdateTime = currentTime
        
        oldLady.update(deltaTime: dt)
        
        //        checkSimpleCollision()
        
    }
    
    //    override func update(_ currentTime: TimeInterval) {
    //
    //        player.position = CGPoint(x: player.position.x , y: player.position.y)
    //        if lastUpdateTime > 0 {
    //            dt = currentTime - lastUpdateTime
    //        } else {
    //            dt = 0 }
    //        lastUpdateTime = currentTime
    //        debugPrint("\(dt*1000) milliseconds since last update")
    //
    //    }
    
    
    
}



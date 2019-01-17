//
//  ViewController.swift
//  catchWordsAR
//
//  Created by claudio Cavalli on 17/01/2019.
//  Copyright © 2019 claudio Cavalli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
          setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }


    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "orange" {
                
                
            }
        }
        
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        
         if( self.sceneView.scene.rootNode.childNodes.count < 10){
            for _ in 0..<1{
            guard anchor is ARPlaneAnchor else { return }
            
        
            let text = SCNNode(text: self.randomString(length: 10), extrusionDepth: 1, color: UIColor.random(), position: SCNVector3(randomPosition(lowerBound: -20, upperBound: 20),randomPosition(lowerBound: -20, upperBound: 20), randomPosition(lowerBound: -120.0, upperBound: -10.3)) , scale: SCNVector3(1, 1, 1), identifier: "orange")
        
            node.runAction(SCNAction.wait(duration: 1)){
                DispatchQueue.main.async {
    
                    self.sceneView.scene.rootNode.addChildNode(text)
                    
                    print("addatp")
                    
                }}
            }
        }
    }
    
    
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        let scene = SCNScene(named: "art.scnassets/arkit.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.session.delegate = self
        
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    
    func randomPosition (lowerBound lower:Float, upperBound upper:Float) -> Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
}



extension SCNNode{
    
    convenience init(text: String, extrusionDepth: CGFloat, color: UIColor, position: SCNVector3, scale: SCNVector3,identifier: String){
        
        self.init()
        let scnText = SCNText(string: text, extrusionDepth: extrusionDepth)
        scnText.firstMaterial?.diffuse.contents = color
        scnText.font = UIFont(name: "Helvetica", size: 20)
        self.position = position
        self.scale = scale
    
        self.geometry = scnText
        self.name = identifier
        
    }
    
    
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

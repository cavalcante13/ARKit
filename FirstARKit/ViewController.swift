//
//  ViewController.swift
//  FirstARKit
//
//  Created by Diego on 26/10/17.
//  Copyright © 2017 Diego. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!

    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let node = SCNNode()
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        node.geometry = box
        
        sceneView.scene = SCNScene()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting   = true
        sceneView.session.run(configuration)
    }
    
    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        let x = random(-0.3, maxValue: 0.3)
        let y = random(-0.3, maxValue: 0.3)
        let z = random(-0.3, maxValue: 0.3)
        
        node.position = SCNVector3(x,y,z)
        sceneView.scene.rootNode.addChildNode(node)
    }
 
    @IBAction func reset(_ sender : Any) {
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateHierarchy { (node, _) in
            node.removeFromParentNode()
        }
        
        sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    
    func random(_ minValue : CGFloat, maxValue : CGFloat)-> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(minValue - maxValue) + min(minValue, maxValue)
    }
}

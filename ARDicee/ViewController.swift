//
//  ViewController.swift
//  ARDicee
//
//  Created by Eliu Efraín Díaz Bravo on 18/11/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let diceScene = SCNScene(named: "art.scnassets/dice.scn")!
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
            diceNode.position = SCNVector3(0, 0, -0.2)
            sceneView.scene.rootNode.addChildNode(diceNode)
        }
        
//        let madaraScene = SCNScene(named: "art.scnassets/madaraUchiha.scn")!
//        if let madaraNode = madaraScene.rootNode.childNode(withName: "Sphere_for_copying_normals_to_madara_face_Sphere.001", recursively: true) {
//            madaraNode.position = SCNVector3(0, -1, -0.5)
//            sceneView.scene.rootNode.addChildNode(madaraNode)
//        }
        
        // Adding custom objects cube / sphere
//        let cube = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.01)
//        let sphere = SCNSphere(radius: 0.2)
//
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "art.scnassets/earth.jpg")
//
//        sphere.materials = [material]
//
//        let node = SCNNode()
//
//        node.position = SCNVector3(0.0, 0.1, -0.5)
//
//        node.geometry = sphere
//
//        sceneView.scene.rootNode.addChildNode(node)
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}

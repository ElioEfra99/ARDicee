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
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
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
//            madaraNode.position = SCNVevctor3(0, -1, -0.5)
//            sceneView.scene.rootNode.addChildNode(madaraNode)
//        }
        
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
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            let planeAnchor = anchor as! ARPlaneAnchor
            
            // Creating grid material for plane
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            // Creating plane and applying materials
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            plane.materials = [gridMaterial]
            
            // Creating plane node where plane will be positioned
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
            
            planeNode.geometry = plane

            node.addChildNode(planeNode)
            
        } else {
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            
            let results = sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent])
            
            if !results.isEmpty {
                print("touched the plane")
            } else {
                print("touched somewhere else")
            }
        }
    }
}

//
//  ViewController.swift
//  AR Drawing
//
//  Created by HideakiTouhara on 2017/10/30.
//  Copyright © 2017年 HideakiTouhara. All rights reserved.
//

import UIKit
import ARKit
import Accelerate

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var draw: UIButton!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configuration.planeDetection = .horizontal

        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
//        guard let pointOfView = sceneView.pointOfView else { return }
//        let transform = pointOfView.transform
//        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
//        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
//        let currentPositionOfCamera = orientation + location
//        DispatchQueue.main.async {
//            if self.draw.isHighlighted {
//                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
//                sphereNode.position = currentPositionOfCamera
//                self.sceneView.scene.rootNode.addChildNode(sphereNode)
//                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//            } else {
//                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
//                pointer.name = "pointer"
//                pointer.position = currentPositionOfCamera
//
//                self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
//                    if node.name == "pointer" {
//                        node.removeFromParentNode()
//                    }
//                })
//
//                self.sceneView.scene.rootNode.addChildNode(pointer)
//                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//            }
//        }
        
        
    }
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
//        let tapPoint = sender.location(in: sceneView)
//        let results = sceneView.hitTest(tapPoint, types: .featurePoint)
//        print("tap")
//        if let hitPoint = results.first {
//            let point = SCNVector3(hitPoint.worldTransform.columns.3.x, hitPoint.worldTransform.columns.3.y, hitPoint.worldTransform.columns.3.z)
//            let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
//            sphereNode.position = point
//            self.sceneView.scene.rootNode.addChildNode(sphereNode)
//            sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//            print("object")
//        }
    }
    
    @IBAction func dragged(_ sender: UIPanGestureRecognizer) {
        
        let tapPoint = sender.location(in: sceneView)
        let results = sceneView.hitTest(tapPoint, types: .featurePoint)
        if let hitPoint = results.first {
            let length = sqrt(hitPoint.worldTransform.columns.3.x * hitPoint.worldTransform.columns.3.x + hitPoint.worldTransform.columns.3.y * hitPoint.worldTransform.columns.3.y + hitPoint.worldTransform.columns.3.z * hitPoint.worldTransform.columns.3.z)
            let point = SCNVector3(hitPoint.worldTransform.columns.3.x / length, hitPoint.worldTransform.columns.3.y / length, hitPoint.worldTransform.columns.3.z / length)
            let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
            sphereNode.position = point
            self.sceneView.scene.rootNode.addChildNode(sphereNode)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        }
    }
    
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}


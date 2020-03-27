//
//  ViewController.swift
//  SceneKitPoC
//
//  Created by Terry Wang on 3/26/20.
//  Copyright © 2020 Terry Wang. All rights reserved.
//  https://sketchfab.com/3d-models/storm-trooper-helmet-14af0d84b5d6407d9540e2b4ea1aae5a

import UIKit
import SceneKit
import QuickLook
import ARKit

class SceneViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!

    @IBAction func didPressRefresh(_ sender: Any) {
        setupUSDZ()
    }

    @IBAction func didPressAction(_ sender: Any) {
        setupPreview()
    }

    var currentModelName: String? = "FILA"

    var currentModelUrl: URL? {
        return Bundle.main.url(forResource: currentModelName, withExtension: "usdz")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        guard let bg = UIImage(named: "onboarding-background") else { return }
        view.backgroundColor = UIColor(patternImage: bg)
        //setupOBJ()
        setupUSDZ()
    }

    func setupUSDZ() {
        currentModelName = ["Corona", "Helmet", "FILA"].filter{ $0 != currentModelName }.randomElement()
        guard let url = currentModelUrl else { return }
        let scene = try? SCNScene(url: url, options: [.checkConsistency: true])
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.allowsCameraControl = true
    }

    func setupPreview() {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true, completion: nil)
    }
}

extension SceneViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return currentModelUrl! as QLPreviewItem
    }


}

extension SceneViewController {
    func setupOBJ() {

        // 1: Load .obj file
        let scene = SCNScene(named: "Camera.obj")

        // 2: Add camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        // 3: Place camera
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 105)
        // 4: Set camera on scene
        scene?.rootNode.addChildNode(cameraNode)

        // 5: Adding light to scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
        scene?.rootNode.addChildNode(lightNode)

        // 6: Creating and adding ambien light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)

        // If you don't want to fix manually the lights
        sceneView.autoenablesDefaultLighting = true

        // Allow user to manipulate camera
        sceneView.allowsCameraControl = true

        // Show FPS logs and timming
        // sceneView.showsStatistics = true

        // Set background color
        //sceneView.backgroundColor = UIColor.white

        // Allow user translate image
        sceneView.cameraControlConfiguration.allowsTranslation = false

        // Set scene settings
        sceneView.scene = scene
    }

}

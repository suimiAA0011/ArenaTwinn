//
//  ARviewModel.swift
//  ArenaTwin0
//
//  Created by salma on 08/04/2025.
//

// ViewModels/ARViewModel.swift
// ViewModels/ARViewModel.swift
// ViewModels/ARViewModel.swift
import Foundation
import ARKit
import SceneKit

class ARViewModel: NSObject, ObservableObject, ARSCNViewDelegate {
    @Published var isARSessionRunning = false
    private var arSession: ARSession?
    private var sceneView: ARSCNView?
    
    override init() {
        super.init()
        setupARSession()
    }
    
    func setupARSession() {
        arSession = ARSession()
        arSession?.delegate = self
    }
    
    func configureSceneView(_ sceneView: ARSCNView) {
        self.sceneView = sceneView
        sceneView.delegate = self
        sceneView.session = arSession! 
        sceneView.scene = SCNScene()
        
        // Enable default lighting for better visibility
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        // Start the AR session immediately
        startARSession()
    }
    
    func startARSession() {
        guard ARWorldTrackingConfiguration.isSupported else {
            print("ARWorldTrackingConfiguration is not supported on this device.")
            return
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical] // Detect horizontal and vertical surfaces
        configuration.environmentTexturing = .automatic // Add realistic lighting and textures
        arSession?.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        isARSessionRunning = true
    }
    
    func pauseARSession() {
        arSession?.pause()
        isARSessionRunning = false
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // When a plane is detected, add the 3D stadium model
        guard anchor is ARPlaneAnchor else { return }
        
        // Load the stadium model
        guard let stadiumScene = SCNScene(named: "stadium_model.scn") else {
            print("Error: Could not load stadium_model.scn")
            return
        }
        
        // Get the root node of the stadium model
        let stadiumNode = stadiumScene.rootNode
        
        // Scale the model to fit in the AR environment (adjust as needed)
        let scaleFactor: Float = 0.01 // Scale down to 1% of original size (adjust based on your model)
        stadiumNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        
        // Position the model on the detected plane
        if let planeAnchor = anchor as? ARPlaneAnchor {
            stadiumNode.position = SCNVector3(
                planeAnchor.center.x,
                planeAnchor.center.y,
                planeAnchor.center.z
            )
        }
        
        // Add the stadium model to the scene
        node.addChildNode(stadiumNode)
    }
}

extension ARViewModel: ARSessionDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("AR Session failed: \(error.localizedDescription)")
        isARSessionRunning = false
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("AR Session was interrupted")
        isARSessionRunning = false
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("AR Session interruption ended")
        startARSession()
    }
}
struct PlayerStats {
    let name: String
    let speed: Double
    let shots: Int
    let position: SIMD3<Float>
}

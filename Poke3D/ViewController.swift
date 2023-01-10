//
//  ViewController.swift
//  Poke3D
//
//  Created by JINSEOK on 2023/01/10.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ARImageTrackingConfiguration로 특정 이미지를 찾는다.
        let configuration = ARImageTrackingConfiguration()
        
        // Asset에서 이미치를 인식할 수 있게 만들어 줍니다.
        // inGroupNamed: 생성한 AR Resource Group 폴더의 이름
        // bundle: 위치를 나타낸다. (Bundle.main)
        guard let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: Bundle.main) else { return }
        
        // ARKit에서 어떤 이미지를 추적할 것인가?
        configuration.trackingImages = imageToTrack
        
        // 몇 개의 이미지를 추적할 것인가?
        configuration.maximumNumberOfTrackedImages = 1
        
        print("image Success")
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}

extension ViewController: ARSCNViewDelegate {
    // renderer(_:nodeFor:)를 anchor에 따라 새로운 노드를 추가합니다
    // anchor: 화면에 감지된 이미지의 위치
    // 결과 값으로 3D객체(node)를 리턴합니다.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // 빈 노드를 생성시킵니다.
        let node = SCNNode()
        
        // 이미지를 추적해야 하므로 감지된 anchor를 ARImageAnchor로 형변환을 시켜줍니다.
        guard let imageAnchor = anchor as? ARImageAnchor else { return node }
        
        // 카드를 인식해야 하므로 감지된 카드의 크기를 입력해 준다.(하드코딩 할 필요 X)
        // 카드위에 3D객체 형상(plane)을 렌더링을 시킨다.
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                             height: imageAnchor.referenceImage.physicalSize.height)
        
        // 투명하게 만들기
        plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
        
        // 뼈대 설정
        let planeNode = SCNNode(geometry: plane)
        
        // 이전까지는 plane이 수직으로 생성이 되므로 우리는 스티커에 맞게 90도로 눞여 줘야 한다.
        // eulerAngles은 라디안 각도를 표현하기 위함.
        planeNode.eulerAngles.x = -(Float.pi / 2)
        
        node.addChildNode(planeNode)
        
        // 고스트를 불러 옵시다.
        guard let ghostScene = SCNScene(named: "art.scnassets/Ghost.scn") else { return node }
        
        guard let ghostNode = ghostScene.rootNode.childNodes.first else { return node }
        
        planeNode.addChildNode(ghostNode)
        
        sceneView.autoenablesDefaultLighting =  true


        return node
    }
}

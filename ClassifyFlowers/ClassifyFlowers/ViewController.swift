//
//  ViewController.swift
//  ClassifyFlowers
//
//  Created by JINSEOK on 2023/01/02.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var descroptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        return picker
    }
    
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }
    
    func requestInfo(flowerName: String) {

        let parameters : [String : String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize" : "500"
        ]

        AF.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { response in

            print("get wiki info")
            print(JSON(response.value!))

            let flowerJSON: JSON = JSON(response.value!)

            let pageid = flowerJSON["query"]["pageids"][0].stringValue

            let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue

            let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue

            self.imageView.sd_setImage(with: URL(string: flowerImageURL))

            self.descroptionLabel.text = flowerDescription
        }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // 이미지 고르는 작업이 끝난 뒤 할 일들을 정의
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        // info의 키 값으로 수정한 이미지를 받아온다.
        guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            fatalError("Failed Original Image pick")
        }
        // CoreML로 얻을 수 있는 이미지 형태로 변형(CIImage)
        guard let coreImage = CIImage(image: userPickedImage) else {
            fatalError("Faild convert CIImage")
        }
        detect(image: coreImage)
    }
    
    // CoreML의 CIImage를 처리하고 해석하기 위한 메서드 생성
    func detect(image: CIImage) {
        // Vision프레임워크의 VNCoreMLModel 컨터이너를 사용하여 CoreML의 모델인 FlowerClassifier를 객체를 생성 후 model에 접근한다.
        // 이것은 모델의 이미지를 분류하기 위해 사용 됩니다.
        guard let model = try? VNCoreMLModel(for: FlowerShop(configuration: .init()).model) else {
            fatalError("Loading CoreML Model Failed")
        }
        let request = VNCoreMLRequest(model: model) { request, error in
            guard error == nil else {
                fatalError("Failed Request")
            }
            // VNClassificationObservation로 식별자의 이름(꽃 이름)을 확인하기 위해 변환해준다.
            guard let classification = request.results as? [VNClassificationObservation] else {
                fatalError("Faild convert VNClassificationObservation")
            }
            
            if let fitstItem = classification.first {
                self.navigationItem.title = fitstItem.identifier.capitalized
                self.requestInfo(flowerName: fitstItem.identifier)
            }
        }
        // 함수의 파라미터를 받아서 perform을 요청하여 분석한다.
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}

extension UIImagePickerController {
    open override var childForStatusBarHidden: UIViewController? {
        return nil
    }

    open override var prefersStatusBarHidden: Bool {
        return true
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fixCannotMoveEditingBox()
    }
    
    private func fixCannotMoveEditingBox() {
        if let cropView = cropView, let scrollView = scrollView, scrollView.contentOffset.y == 0 {
            let top: CGFloat = cropView.frame.minY + self.view.frame.minY
            let bottom = scrollView.frame.height - cropView.frame.height - top
            scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
            
            var offset: CGFloat = 0
            if scrollView.contentSize.height > scrollView.contentSize.width {
                offset = 0.5 * (scrollView.contentSize.height - scrollView.contentSize.width)
            }
            scrollView.contentOffset = CGPoint(x: 0, y: -top + offset)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.fixCannotMoveEditingBox()
        }
    }
    
    private var cropView: UIView? {
        return findCropView(from: self.view)
    }
    
    private var scrollView: UIScrollView? {
        return findScrollView(from: self.view)
    }
    
    private func findCropView(from view: UIView) -> UIView? {
        let width = UIScreen.main.bounds.width
        let size = view.bounds.size
        if width == size.height, width == size.height {
            return view
        }
        for view in view.subviews {
            if let cropView = findCropView(from: view) {
                return cropView
            }
        }
        return nil
    }
    
    private func findScrollView(from view: UIView) -> UIScrollView? {
        if let scrollView = view as? UIScrollView {
            return scrollView
        }
        for view in view.subviews {
            if let scrollView = findScrollView(from: view) {
                return scrollView
            }
        }
        return nil
    }
}

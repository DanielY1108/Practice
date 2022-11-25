//
//  ViewController.swift
//  imagePicker
//
//  Created by JinSeok Yang on 2022/08/27.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let originalImage:UIImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.imageView.image = originalImage
            }
            self.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func touchUpSelcectImageButton(_ sender: UIButton) {
        self.present(self.imagePicker,
                     animated: true,
                     completion: nil)
    }
}

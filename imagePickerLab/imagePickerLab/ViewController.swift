//
//  ViewController.swift
//  imagePickerLab
//
//  Created by Sam Roman on 10/1/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var folderbutton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    
    @IBAction func cameraAction(_ sender: UIButton) {
        imagePickerViewcontroller.sourceType = .camera
        present(imagePickerViewcontroller, animated: true)
    }
    
    
    @IBAction func folderAction(_ sender: UIButton) {
        imagePickerViewcontroller.sourceType = .photoLibrary
        present(imagePickerViewcontroller, animated: true, completion: nil)
    }
    
    
    var photoLibraryAccess = false
    
    private var imagePickerViewcontroller: UIImagePickerController!
    
    
    
    private func setupImagePickerViewController() {
               imagePickerViewcontroller = UIImagePickerController()
               imagePickerViewcontroller.delegate = self
               if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                   cameraButton.isEnabled = false
               }
       }
    
    override func viewDidLoad() {
        setupImagePickerViewController()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}


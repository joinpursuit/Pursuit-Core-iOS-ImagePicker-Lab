//
//  ViewController.swift
//  ImagePickerProj
//
//  Created by Kevin Natera on 10/4/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBAction func textFieldTyped(_ sender: UITextField) {
        nameLabel.text = textFieldOutlet.text
        //textFields are currently glitched in Xcode11
    }
    
    var image = UIImage() {
        didSet {
            imageOutlet.image = image
        }
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        let imagePickerViewController = UIImagePickerController()
             imagePickerViewController.delegate = self
             imagePickerViewController.sourceType = .photoLibrary
             
             present(imagePickerViewController, animated: true, completion: nil)
             
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            //couldn't get image :(
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}

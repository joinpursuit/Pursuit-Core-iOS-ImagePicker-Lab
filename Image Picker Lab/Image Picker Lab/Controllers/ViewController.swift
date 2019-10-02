//
//  ViewController.swift
//  Image Picker Lab
//
//  Created by Michelle Cueva on 10/1/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var nameTextfield: UITextField!
    
    var savedImage : UIImage! {
        didSet {
            photoImage.image = savedImage
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func SaveInfo(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
        guard let text = nameTextfield.text else {return}
        guard let image = photoImage.image else { return }
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }

        let user = User(userName: text, image: data)

        do {
            try UserPersistenceHelper.manager.save(user: user)
        }catch {
            print(error)
            
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func changeImage(_ sender: Any) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            return setupCaptureSession()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupCaptureSession()
                }
            }
            
        case .denied: // The user has previously denied access.
            return alertCameraAccessNeeded()
            
        case .restricted: // The user can't grant access due to restrictions.
            return
            
        default:
            return
        }
        
    }
    
    func setupCaptureSession() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to make full use of this app.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
        present(alert, animated: true, completion: nil)}
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        savedImage = image
        self.dismiss(animated: true, completion: nil)
    }
}


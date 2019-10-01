//
//  ViewController.swift
//  ImagePicker-Lab
//
//  Created by Radharani Ribas-Valongo on 10/1/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate{
    //MARK: -- Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    //MARK: -- Properties
    
    var photoLibraryAccess = false
    var image = UIImage() {
        didSet {
            profileImage.image = image
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPhotoLibraryAccess()
    }
    @IBAction func actionSheetForDifferentActions(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Edit Some Things", message: "What would you like to edit?", preferredStyle: .actionSheet)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        actionSheet.addAction(UIAlertAction(title: "Profile Image", style: .default, handler: { (action:UIAlertAction) in
            
            if self.photoLibraryAccess {
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController,animated: true)
            } else {
                let noAuthenticationAlertalertVC = UIAlertController(title: "ACCESS DENIED", message: "This app has not been authorized to access your photo library. That's sad :(", preferredStyle: .alert)
                noAuthenticationAlertalertVC.addAction(UIAlertAction (title: "DENY", style: .destructive, handler: nil))
                self.present(noAuthenticationAlertalertVC, animated: true, completion: nil)
                
                noAuthenticationAlertalertVC.addAction(UIAlertAction (title: "LET ME IN", style: .default, handler: { (action) in
                    self.photoLibraryAccess = true
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Name", style: .default, handler: { (action:UIAlertAction) in
            self.editName()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Username", style: .default, handler: { (action:UIAlertAction) in
            //DO STUFF
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(actionSheet,animated: true, completion: nil)
    }
    
    private func checkPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            print(status)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({status in
                switch status {
                case .authorized:
                    self.photoLibraryAccess = true
                    print(status)
                case .denied:
                    self.photoLibraryAccess = false
                    print("denied")
                case .notDetermined:
                    print("not determined")
                case .restricted:
                    print("restricted")
                }
            })
            
        case .denied:
            let noAuthenticationAlert = UIAlertController(title: "Denied", message: "This app has not been authorized to access your photo library. fdgkjhskjhkdahgkjahdsgkhsxkdghakrsdhkjshdgkvadhsgkahwesdkghrbdjsgxhvkerdshgfjkghsdgkhaerdkgfherskdxghkaershgdjkaeshdgkaf Please change your settings", preferredStyle: .alert)
            noAuthenticationAlert.addAction(UIAlertAction (title: "Ok", style: .default, handler: nil))
            self.present(noAuthenticationAlert, animated: true, completion: nil)
        case .restricted:
            print("restricted")
        }
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("Error grabbing image")
            return
        }
        
        self.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    private func editName() {
        
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "popover")
        let nav = UINavigationController(rootViewController: popoverContent ?? UIViewController())
        
        self.present(nav, animated: true, completion: nil)
        
    }
}

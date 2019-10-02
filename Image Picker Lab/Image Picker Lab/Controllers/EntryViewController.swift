//
//  EntryViewController.swift
//  Image Picker Lab
//
//  Created by Michelle Cueva on 10/1/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        do {
            let users = try UserPersistenceHelper.manager.getUser()
            if let user = users.last {
                let image = UIImage(data: user.image)
                DispatchQueue.main.async {
                    self.userImage.image = image
                    self.nameLabel.text = user.userName
                }
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func pushToSettings(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle:nil)
        let AddPhotoVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as! ViewController
        self.present(AddPhotoVC, animated: true, completion: nil) //Presents modally
        
    }
    
}

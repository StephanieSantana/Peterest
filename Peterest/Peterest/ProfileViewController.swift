//
//  ProfileViewController.swift
//  Peterest
//
//  Created by Yingying Chen on 4/8/19.
//  Copyright © 2019 Yingying Chen. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage


class ProfileViewController: UIViewController{
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load user data
        let userName = PFUser.current()?.object(forKey: "username") as! String
        
        let userBio = PFUser.current()?.object(forKey: "userBio") as! String
        
        usernameLabel.text = userName
        bioLabel.text = userBio
        
        let userImage = PFUser.current()?.object(forKey: "profileImage") as! PFFileObject
        let urlString = userImage.url!
        let url = URL(string: urlString)!
        
        imageView.af_setImage(withURL: url)
        
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "sendUpdateSegue" {
            let vc : CameraProfileViewController = segue.destination as! CameraProfileViewController
            vc.delegate = self
            
            //passes current data to profile edit VC
            vc.finalUsername = usernameLabel.text
            vc.finalBio = bioLabel.text
            vc.finalImage = imageView.image
        }
     }
    
    
}
   
extension ProfileViewController: UpdateDelegate {
    //Gets updates from profile edit VC
    func didUpdate(name: String, bio: String, image: UIImage) {
        usernameLabel.text = name
        bioLabel.text = bio
        imageView.image = image
    }
    
}

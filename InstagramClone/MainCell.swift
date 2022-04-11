//
//  MainCell.swift
//  InstagramClone
//
//  Created by Mehmet Bilir on 11.04.2022.
//

import UIKit
import Firebase

class MainCell: UITableViewCell {

    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let firestore = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!){
            let likeStore = ["like" : likeCount+1] as [String:Any]
            firestore.collection("Posts").document(idLabel.text!).setData(likeStore, merge: true)
            
        }
    }
    
}

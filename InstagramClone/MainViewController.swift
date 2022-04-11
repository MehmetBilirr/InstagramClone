//
//  MainViewController.swift
//  InstagramClone
//
//  Created by Mehmet Bilir on 11.04.2022.
//

import UIKit
import Firebase
import SDWebImage
class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var postedByArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainCell
        cell.emailLabel.text = postedByArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userImage.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))

        return cell
    }
    
    func getDataFromFirestore(){
        let firestoreData = Firestore.firestore()
        firestoreData.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    
                    for document in snapshot!.documents {
                        
                        if let documentId = document.documentID as? String {
                            
                            
                        }
                        if let postedBy = document.get("postedBy") as? String {
                            self.postedByArray.append(postedBy)
                        }
                        if let comment = document.get("comment") as? String {
                            self.userCommentArray.append(comment)
                        }
                        if let like = document.get("like") as? Int {
                            self.likeArray.append(like)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postedByArray.count
        
    }
    

    
}

//
//  UserProfileViewController.swift
//  WordTomb
//
//  Created by Udeshi on 5/27/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var userIcon: UIImageView!
    let picker = UIImagePickerController() // for image upload
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct Record {
        var categoryImageName: String
        var marks: String
        var rank: String
    }
    var historyRecords = [
        Record (categoryImageName: "animals",marks: "400", rank:"10001"),
        Record (categoryImageName: "sports",marks: "100", rank:"30641"),
        Record (categoryImageName: "technology",marks: "100", rank:"50601"),
        Record (categoryImageName: "music",marks: "0", rank:"80001"),
        Record (categoryImageName: "movies",marks: "160", rank:"14501"),
        Record (categoryImageName: "underwater",marks: "700", rank:"7001")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
      
        
        //set profile image
        
        let decoded = UserDefaultsHandler().getObj(key: "Session")
        let userDetails = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data)
        var image = UIImage(named:"userIcon.png")
        if(userDetails != nil) {
            let decodedUserDetails =  userDetails as! UserDetails
            if decodedUserDetails.profileImageUrl! != "" {
                image = UIImage(contentsOfFile: decodedUserDetails.profileImageUrl!)
            }
            userName.text  = decodedUserDetails.userName != "" ? decodedUserDetails.userName : "Alpha"
        }
        userIcon.image = image
        
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyRecords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell {
        let cell: MarksCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MarksCollectionViewCell
        cell.categoryImage.image = UIImage(named: historyRecords[indexPath.row].categoryImageName)
        cell.userMarks.text = historyRecords[indexPath.row].marks
        cell.userRanking.text = historyRecords[indexPath.row].rank
        return cell
    }
    

    @IBAction func uploadImage(_ sender: UIButton) {
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard (info[UIImagePickerControllerEditedImage] as? UIImage) != nil else {return}
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        print(imagePath)
        let decoded = UserDefaultsHandler().getObj(key: "Session")
        let userDetails = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data)
        if(userDetails != nil) {
            let decodedUserDetails =  userDetails as! UserDetails

            User().updateUserProfile(profilePath: imagePath.path, userId: (decodedUserDetails.id)!)
            
            decodedUserDetails.profileImageUrl = imagePath.path
            print(imagePath.path)
            userIcon.image = UIImage(contentsOfFile: imagePath.path)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: decodedUserDetails)
            
            UserDefaultsHandler().saveObj(data: encodedData,key: "Session")
        }
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func getDocumentsDirectory()-> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

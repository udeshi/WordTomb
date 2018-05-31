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
              Record (categoryImageName: "underwater",marks: "700", rank:"7001"),]
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
collectionView.dataSource = self
        collectionView.delegate = self

        //set profile image
 var userDetails: UserDetails? = nil
        userDetails = UserDefaultsHandler().getOtherData(key: "Session") as? UserDetails
        let image =   (userDetails != nil && (userDetails?.profileImageUrl) != "") ? UIImage(contentsOfFile: (userDetails?.profileImageUrl)!) : UIImage(named:"userIcon.png")
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MarksCollectionViewCell
        
        cell.categoryImage = UIImageView (image: UIImage(named: historyRecords[indexPath.section].categoryImageName))
//        let marks = historyRecords[indexPath.section].marks
//              cell.userRanking.text = historyRecords[indexPath.section].rank
//        cell.userMarks.text = "400"
//        
  
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
        var userDetails: UserDetails? = nil
        userDetails = UserDefaultsHandler().getOtherData(key: "Session") as? UserDetails
        if(userDetails != nil) {
            CoreDataHandler.updateUserProfile(profilePath: imagePath.path, userId: (userDetails?.id)!)
        
            userDetails?.profileImageUrl = imagePath.path
         userIcon.image = UIImage(contentsOfFile: imagePath.path)
        UserDefaultsHandler().save(data: userDetails!, key: "Session")
        }
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func getDocumentsDirectory()-> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

//
//  UserProfileViewController.swift
//  WordTomb
//
//  Created by Udeshi on 5/27/18.
//  Copyright © 2018 Udeshi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
 let picker = UIImagePickerController()
    struct Record {
        var categoryImageName: String!
        var marks: Int!
        var rank: Int!
    }
    var historyRecords = [
        Record (categoryImageName: "animals",marks: 400, rank:10001),
          Record (categoryImageName: "sports",marks: 100, rank:30641),
           Record (categoryImageName: "technology",marks: 100, rank:50601),
            Record (categoryImageName: "music",marks: 0, rank:80001),
             Record (categoryImageName: "movies",marks: 160, rank:14501),
              Record (categoryImageName: "underwater",marks: 700, rank:7001),]
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
        
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
        cell.userMarks.text = String( historyRecords[indexPath.section].marks)
        cell.userRanking.text = String(historyRecords[indexPath.section].rank)
        return cell
    }
    @IBAction func uploadImage(_ sender: UIButton) {
        picker.allowsEditing = false
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard (info[UIImagePickerControllerEditedImage] as? UIImage) != nil else {return}
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
//        if let jpegData = UIImageJPEGRepresentation(image,80){
//            try? jpegData
//        }
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func getDocumentsDirectory()-> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

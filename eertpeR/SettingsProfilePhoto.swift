//
//  SettingsProfilePhoto.swift
//  eertpeR
//
//  Created by Frosty on 1/5/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//

import UIKit
import Photos
import Firebase
import FirebaseStorage

@objc(settingsProfilePhoto)
class settingsProfilePhoto: UIViewController,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var takePicButton: UIButton!
    @IBOutlet weak var urlTextView: UITextView!
    @IBOutlet weak var dowloadPicButton: UIButton!
    
    let storageRef = Storage.storage().reference()
    let picToRemove = constProfilePicUrl

    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously(completion: { (user: User?, error: Error?) in
                if let error = error {
                    self.urlTextView.text = error.localizedDescription
                    self.takePicButton.isEnabled = false
                } else {
                    self.urlTextView.text = ""
                    self.takePicButton.isEnabled = true
                }
            })
        }
        // [END storageauth]
    }
    
    // MARK: - Image Picker
    
    @IBAction func didTapTakePicture(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion:nil)
    }
  
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion:nil)
        
        urlTextView.text = "Beginning Upload"
        // if it's a photo from the library, not an image from the camera
        if #available(iOS 8.0, *), let referenceUrl = info[UIImagePickerControllerReferenceURL] as? URL {
            let assets = PHAsset.fetchAssets(withALAssetURLs: [referenceUrl], options: nil)
            let asset = assets.firstObject
            asset?.requestContentEditingInput(with: nil, completionHandler: { (contentEditingInput, info) in
                let imageFile = contentEditingInput?.fullSizeImageURL
                let filePath = Auth.auth().currentUser!.uid +
                "/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\(imageFile!.lastPathComponent)"
                // [START uploadimage]
                self.storageRef.child(filePath)
                    .putFile(from: imageFile!, metadata: nil) { (metadata, error) in
                        if let error = error {
                            print("Error uploading: \(error)")
                            self.urlTextView.text = "Upload Failed"
                            return
                        }
                        self.uploadSuccess(metadata!, storagePath: filePath)
                }
                // [END uploadimage]
            })
        } else {
            guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
            let imagePath = Auth.auth().currentUser!.uid +
            "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            self.storageRef.child(imagePath).putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error uploading: \(error)")
                    self.urlTextView.text = "Upload Failed"
                    return
                }
                self.uploadSuccess(metadata!, storagePath: imagePath)
            }
        }
    }
    
    func uploadSuccess(_ metadata: StorageMetadata, storagePath: String) {
        print("Upload Succeeded!")
        self.urlTextView.text = metadata.downloadURL()?.absoluteString
        UserDefaults.standard.set(storagePath, forKey: "storagePath")
        UserDefaults.standard.synchronize()
        updateProfileWithPicPath(thePath: (metadata.downloadURL()?.absoluteString)!)
        self.dowloadPicButton.isEnabled = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
    
    func updateProfileWithPicPath(thePath: String) {
        let userProfileDetailRef = Database.database().reference(withPath: "Profiles").child(userID)
        userProfileDetailRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild("profilePic"){
                let update = ["profilePic":thePath]
                userProfileDetailRef.updateChildValues(update, withCompletionBlock: { (err, ref) in
                    if err != nil {
                        print("profile update error: \(String(describing: err))")
                        return
                    }
                    else {
                        //upon successfull uplaod, reset the constant path to the new pic
                         constProfilePicUrl = thePath
                        
                        //if there is an existing profile pic, then delete it from storage
                        if !self.picToRemove.isEmpty {
                            let picStorageRef = Storage.storage().reference(forURL: self.picToRemove)
                        
                            //Removes old image from storage
                            DispatchQueue.global(qos: .background).async {
                                picStorageRef.delete { error in
                                    if let error = error {
                                        print(error)
                                    }
                                }
                                DispatchQueue.main.async {
                                    print("deletion method has completed")
                                }
                            }
                        }
                    }
                })
            }
            else {
                print("no profilePic key exists")
            }
        })
    }
}

//
//  SelectPictureViewController.swift
//  Snapchat-Clone
//
//  Created by Jane Zhu on 4/18/19.
//  Copyright © 2019 JaneZhu. All rights reserved.
//

import UIKit
import FirebaseStorage
import Toucan


class SelectPictureViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var selectedPhotoImageView: UIImageView!
    
    private var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
    }
    

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        imagePicker?.sourceType = .camera
        if imagePicker != nil {
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func photoLibraryPressed(_ sender: UIBarButtonItem) {
        imagePicker?.sourceType = .photoLibrary
        if imagePicker != nil {
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard let image = selectedPhotoImageView.image,
            let message = messageTextField.text,
            !message.isEmpty else {
                showAlert(alert: "Image and message cannot be empty.")
                return }
        //TODO: save photo and send to Firebase
        let imageRef = Storage.storage().reference().child("images/\(NSUUID().uuidString).jpeg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        let resizedImage = Toucan(image: image).resize(CGSize(width: 300, height: 300)).image
        if let imageData = resizedImage?.jpegData(compressionQuality: 0.5) {
            let uploadTask = imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("upload task error: \(error)")
                } else if let _ = metadata {
                    
                }
            }
            uploadTask.observe(.failure) { (snapshot) in
                //
            }
            uploadTask.observe(.pause) { (snapshot) in
                //
            }
            uploadTask.observe(.progress) { (snapshot) in
                //
            }
            uploadTask.observe(.resume) { (snapshot) in
                //
            }
            uploadTask.observe(.success) { (snapshot) in
                //
                imageRef.downloadURL(completion: { (url, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let url = url {
                        self.performSegue(withIdentifier: "SelectReceiverSegueway", sender: url.absoluteString)
                    }
                })
            }
        }
//).putData(imageData, metadata: nil) { (metadata, error) in
//                if let error = error {
//                    self.showAlert(alert: error.localizedDescription)
//                } else if let metadata = metadata {
//                    metadata.storageReference?.downloadURL(completion: { (url, error) in
//                        if let url = url {
//                            self.performSegue(withIdentifier: "SelectReceiverSegueway", sender: url.absoluteString)
//                        } else if let error = error {
//                            print("error getting image url: \(error.localizedDescription)")
//                        }
//                    })
//                }
//            }
        }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let downloadURL = sender as? String {
            if let selectVC = segue.destination as? SelectReceiverTableViewController {
                selectVC.downloadURL = downloadURL
            }
        }
    }
}

extension SelectPictureViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedPhotoImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}

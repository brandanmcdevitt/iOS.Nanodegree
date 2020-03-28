//
//  MemeViewController.swift
//  Project 02 MemeMe 1.0
//
//  Created by Brandan McDevitt on 28/03/2020.
//  Copyright © 2020 Brandan McDevitt. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    private let textAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.5
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.delegate = self
        bottomText.delegate = self
        imageView.contentMode = .scaleAspectFit
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        actionButton.isEnabled = false
        setupTextFields(textFields: [topText, bottomText])
        
        subscribeToKeyboardNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    private func setupTextFields(textFields: [UITextField]) {
        textFields[0].text = "TOP"
        textFields[1].text = "BOTTOM"
        textFields.forEach {
            $0.defaultTextAttributes = textAttributes
            $0.backgroundColor = .clear
            $0.textAlignment = .center
            $0.borderStyle = .none
        }
    }

    @IBAction func pickImageFromLibrary(_ sender: UIBarButtonItem) {
        pickImage(source: .photoLibrary)
    }
    
    @IBAction func pickImageFromCamera(_ sender: UIBarButtonItem) {
        pickImage(source: .camera)
    }
    
    private func pickImage(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true)
    }
    
    @IBAction func share(_ sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        // exclude save to camera roll since we manual save anyway
        activityController.excludedActivityTypes = [.saveToCameraRoll]
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
            } else {
                print("Cancelled")
            }
        }
        present(activityController, animated: true)
    }
    
    func save() {
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imageView.image!, memeImage: generateMemedImage())
        UIImageWriteToSavedPhotosAlbum(meme.memeImage, nil, nil, nil)
    }
    
    func generateMemedImage() -> UIImage {
        toolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolbar.isHidden = false

        return memedImage
    }
}

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            actionButton.isEnabled = true
            dismiss(animated: true, completion: nil)
        }
    }
}

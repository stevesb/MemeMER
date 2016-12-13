//
//  ViewController.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/8/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        setupNavBar()
        memeImageView()
        setupToolBar()
        setupTapHideKeyboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let cameraButton = cameraButton {
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        }
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupNavBar() {
        navigationItem.title = "MemeMER"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    func memeImageView() {
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/4).isActive = true
        
        view.addSubview(topTextField)
        topTextField.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        topTextField.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        view.addSubview(bottomTextField)
        bottomTextField.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        bottomTextField.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    }
    
    func setupToolBar() {
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = UIColor.lightGray
        navigationController?.toolbar.tintColor = UIColor.black
        let addButton = UIBarButtonItem(title: "Album", style: .plain, target: self, action: #selector(addButtonTapped))
        cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        spacer.width = 75
        toolbarItems = [spacer, cameraButton, spacer, addButton, spacer]
    }
    
    func setupTapHideKeyboard() {
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap))
        hideTap.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(hideTap)
    }
    
    lazy var memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: CGFloat(-4)]

    lazy var topTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextAttributes = self.memeTextAttributes
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "TOP"
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.delegate = self
        textField.tag = 0
        textField.returnKeyType = .next
        return textField
    }()
    
    lazy var bottomTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextAttributes = self.memeTextAttributes
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "BOTTOM"
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.delegate = self
        textField.tag = 1
        textField.returnKeyType = .done
        return textField
    }()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.clear
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
        
    }()
    
    func addButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.setEditing(true, animated: true)
        present(imagePicker, animated: true, completion: nil)
    }

    func cameraButtonTapped() {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        camera.allowsEditing = true
        camera.setEditing(true, animated: true)
        present(camera, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = image
            dismiss(animated: true, completion: nil)
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyboardHeight(notification);
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
            view.frame.origin.y = 0
    }
    
    func hideKeyboardTap(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
        
        init (topText: String, bottomText: String, originalImage : UIImage, memedImage: UIImage){
            self.topText = topText
            self.bottomText = bottomText
            self.originalImage = originalImage
            self.memedImage = memedImage
        }
    
    }
    
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        navigationItem.leftBarButtonItem?.isEnabled = true
        return memedImage
    }
    
    func save(memedImage: UIImage) {
        let memedImage = generateMemedImage()
        let _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memedImage, memedImage: memedImage)
    }
    
    func shareButtonTapped(image: UIImage) {
        
        let memedImage = generateMemedImage()
        let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityView.completionWithItemsHandler = {activity, completed, items, error in
            if completed {
                self.save(memedImage: image)
            }
            
        }
        
        present(activityView, animated: true, completion: nil)
        
    }
    
    func cancelButtonTapped(sender: Any) {
        imageView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        navigationItem.leftBarButtonItem?.isEnabled = false
        
    }
    
}

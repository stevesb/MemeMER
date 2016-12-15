//
//  MemeEditorController.swift
//  MemeMER
//
//  Created by Suad Bayramoglu on 12/8/16.
//  Copyright © 2016 baybros. All rights reserved.
//

import UIKit

class MemeEditorController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var cameraButton: UIBarButtonItem!
    
    var memes: [Meme]!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black

        setupNavBar()
        memeImageView()
        setupToolBar()
        setupTapHideKeyboard()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    
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
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    func setupNavBar() {
        navigationItem.title = "MemeMER"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        navigationItem.leftBarButtonItem?.isEnabled = false
//        navigationController?.navigationBar.barTintColor = UIColor.lightGray
    }
    
    
    func memeImageView() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        
        
        if let nHeight = navigationController?.navigationBar.frame.height, let tbHeight = navigationController?.toolbar.frame.height {
            
            view.addSubview(topTextField)
            topTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: nHeight).isActive = true
            topTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            view.addSubview(bottomTextField)
            bottomTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tbHeight).isActive = true
            bottomTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
        }
    }
    
    func setupToolBar() {
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = UIColor.lightGray
        navigationController?.toolbar.tintColor = UIColor.black
        let albumButton = UIBarButtonItem(title: "Album", style: .plain, target: self, action: #selector(albumButtonTapped))
        cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        spacer.width = 75
        toolbarItems = [spacer, cameraButton, spacer, albumButton, spacer]
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

    func configureTextFields(defaultText: String, textFieldTag: Int, ReturnKeyType: UIReturnKeyType) -> UITextField {
        let textField = UITextField()
        textField.defaultTextAttributes = memeTextAttributes
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = defaultText
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        textField.delegate = self
        textField.tag = textFieldTag
        textField.returnKeyType = ReturnKeyType
        return textField
    }
    
    lazy var topTextField: UITextField = {
        self.configureTextFields(defaultText: "TOP", textFieldTag: 0, ReturnKeyType: .next)
    }()
    
    lazy var bottomTextField: UITextField = {
        self.configureTextFields(defaultText: "BOTTOM", textFieldTag: 1, ReturnKeyType: .done)
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
    
    func pickAnImageFromSource(source: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        imagePicker.allowsEditing = true
        imagePicker.setEditing(true, animated: true)
        present(imagePicker, animated: true, completion: nil)
    }
    
    func albumButtonTapped() {
        pickAnImageFromSource(source: .photoLibrary)
    }

    func cameraButtonTapped() {
        pickAnImageFromSource(source: .camera)
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
            view.frame.origin.y = -getKeyboardHeight(notification)
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
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memedImage, memedImage: memedImage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
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
        dismiss(animated: true, completion: nil)
    }
}

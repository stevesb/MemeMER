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

    var meme: Meme?
    
    var fromDetail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        setupNavBar()
        memeImageView()
        setupToolBar()
        setupTapHideKeyboard()
        
        if let meme = self.meme{
            imageView.image = meme.originalImage
        }
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    
        if meme != nil{
            topTextField.text = meme?.topText
            bottomTextField.text = meme?.bottomText
            imageView.image = meme?.originalImage
        }
    }
    
    func backBtn() {
        present(TabBarController(), animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let cameraButton = cameraButton {
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        }
        subscribeToKeyboardNotifications()
        
        tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
        if fromDetail == true {
            tabBarController?.tabBar.isHidden = false
        }

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
//        navigationItem.leftBarButtonItem?.isEnabled = false
//        navigationController?.navigationBar.barTintColor = UIColor.lightGray
    }

    var toolbarHeight: CGFloat?
    var navigationHeight: CGFloat?
    var totalBarHeight: CGFloat?
    
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    var topTextConstraint: NSLayoutConstraint?
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        setupTextViews()
        
    }
    
    func memeImageView() {
        
//        toolbarHeight = navigationController?.toolbar.frame.height
//        navigationHeight = navigationController?.navigationBar.frame.height
//        totalBarHeight = toolbarHeight! + navigationHeight!

        view.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        
        view.addSubview(topTextField)
        view.addSubview(bottomTextField)
        
        topTextField.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        bottomTextField.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        setupTextViews()
    }
    
    func setupTextViews(){
        
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        let decision = isLandscape ? imageView.frame.height : view.frame.width
        
        let imageWidth = (decision - 40) / 2 // 40 is from the text's height
        
        if topConstraint == nil {
            topConstraint = topTextField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 50)
        }
        topConstraint?.constant = -imageWidth
        topConstraint?.isActive = true
        
        if bottomConstraint == nil {
            bottomConstraint = bottomTextField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: imageWidth)
        }
        bottomConstraint?.constant = imageWidth
        bottomConstraint?.isActive = true
        
        
        let textWidth = min(view.frame.width,view.frame.height)
        if topTextConstraint == nil{
            topTextConstraint = topTextField.widthAnchor.constraint(equalToConstant: textWidth)
            topTextConstraint?.isActive = true
        }
        else{
            topTextConstraint?.constant = textWidth
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
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
        let txt = self.meme != nil ? self.meme?.topText : "TOP"
        return self.configureTextFields(defaultText: txt!, textFieldTag: 0, ReturnKeyType: .next)
    }()
    
    lazy var bottomTextField: UITextField = {
        let txt = self.meme != nil ? self.meme?.topText : "BOTTOM"
        return self.configureTextFields(defaultText: txt!, textFieldTag: 1, ReturnKeyType: .done)
    }()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor.red
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    func pickAnImageFromSource(source: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
//        imagePicker.allowsEditing = true
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
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            dismiss(animated: true, completion: nil)
//            navigationItem.leftBarButtonItem?.isEnabled = true
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
        UIGraphicsBeginImageContext(view.bounds.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
//        navigationItem.leftBarButtonItem?.isEnabled = true
        return memedImage
    }
    
    func save() {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        dismiss(animated: true, completion: nil)
    }
 
    func shareButtonTapped(image: UIImage) {
        
        let memedImage = generateMemedImage()
        let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityView.completionWithItemsHandler = {activity, completed, items, error in
            if completed {
                self.save()
            }
        }
        present(activityView, animated: true, completion: nil)
    }
    
    func cancelButtonTapped(sender: Any) {
        if fromDetail == true {
            let controller = TabBarController()
            navigationController?.present(controller, animated: true, completion: nil)
        } else {
        dismiss(animated: true, completion: nil)
        }
    }
}

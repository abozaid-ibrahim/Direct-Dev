//
//  UIImage+Encoding.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

extension UIImage {
    func convertImageToBase64String() -> String {
        return jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}

extension String {
    func convertBase64StringToImage() -> UIImage {
        let imageData = Data(base64Encoded: self, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
}

import MobileCoreServices
import UIKit

class DSCameraHandler: NSObject {
    private let imagePicker = UIImagePickerController()
    private let isPhotoLibraryAvailable = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    private let isSavedPhotoAlbumAvailable = UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
    private let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
    private let isRearCameraAvailable = UIImagePickerController.isCameraDeviceAvailable(.rear)
    private let isFrontCameraAvailable = UIImagePickerController.isCameraDeviceAvailable(.front)
    private let sourceTypeCamera = UIImagePickerController.SourceType.camera
    private let rearCamera = UIImagePickerController.CameraDevice.rear
    private let frontCamera = UIImagePickerController.CameraDevice.front

    var delegate: UINavigationControllerDelegate & UIImagePickerControllerDelegate
    init(delegate_: UINavigationControllerDelegate & UIImagePickerControllerDelegate) {
        delegate = delegate_
    }

    func getPhotoLibraryOn(canEdit: Bool) {
        if !isPhotoLibraryAvailable, !isSavedPhotoAlbumAvailable { return }
        let type = kUTTypeImage as String

        if isPhotoLibraryAvailable {
            imagePicker.sourceType = .photoLibrary
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
                if availableTypes.contains(type) {
                    imagePicker.mediaTypes = [type]
                    imagePicker.allowsEditing = canEdit
                }
            }

            imagePicker.sourceType = .savedPhotosAlbum
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum) {
                if availableTypes.contains(type) {
                    imagePicker.mediaTypes = [type]
                }
            }
        } else {
            return
        }

        imagePicker.allowsEditing = canEdit
        imagePicker.delegate = delegate
        try! AppNavigator().present(imagePicker)
    }

    func getCameraOn(canEdit: Bool) {
        if !isCameraAvailable { return }
        let type1 = kUTTypeImage as String

        if isCameraAvailable {
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .camera) {
                if availableTypes.contains(type1) {
                    imagePicker.mediaTypes = [type1]
                    imagePicker.sourceType = sourceTypeCamera
                }
            }

            if isRearCameraAvailable {
                imagePicker.cameraDevice = rearCamera
            } else if isFrontCameraAvailable {
                imagePicker.cameraDevice = frontCamera
            }
        } else {
            return
        }

        imagePicker.allowsEditing = false
        imagePicker.showsCameraControls = true
        imagePicker.delegate = delegate
        try! AppNavigator().present(imagePicker)
    }
}

extension ImagePicker {
    func showImagePicker(id: Int = 0) {
        currentImageID = id
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self
        optionMenu.setTint(color: UIColor.appMango)
        let takePhoto = UIAlertAction(title: "Take Photo".localized, style: .default) { (_: UIAlertAction!) in
            camera.getCameraOn(canEdit: false)
        }
        let sharePhoto = UIAlertAction(title: "Photo Library".localized, style: .default) { (_: UIAlertAction!) in
            camera.getPhotoLibraryOn(canEdit: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel) { (_: UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)

        try! AppNavigator().present(optionMenu)
    }

  

//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//
//        let image = info[.editedImage] as? UIImage
//         let fileUrl = info[.imageURL] as? URL
//
//
//        self.receivedImage.onNext((fileUrl?.lastPathComponent,image))
//        // image is our desired image
//
//        picker.dismiss(animated: true, completion: nil)
//    }
}

protocol ImagePicker: UIView, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var disposeBag: DisposeBag { get }
    var currentImageID: Int { get set } //this is just flage to multi picker in same countroller
    var receivedImage: PublishSubject<(String?, UIImage?)> { get set }
}

extension UIAlertController {
    // Set background color of UIAlertController
    func setBackgroudColor(color: UIColor) {
        if let bgView = self.view.subviews.first,
            let groupView = bgView.subviews.first,
            let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }

    // Set title font and title color
    func setTitle(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title) // 1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font: titleFont], // 2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor: titleColor], // 3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        setValue(attributeString, forKey: "attributedTitle") // 4
    }

    // Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let title = self.message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributedString.addAttributes([NSAttributedString.Key.font: titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        setValue(attributedString, forKey: "attributedMessage") // 4
    }

    // Set tint color of UIAlertController
    func setTint(color: UIColor) {
        view.tintColor = color
    }
}
extension String {
    func attachName() -> String {
        let fileName = self
        let startFrom = fileName.count > 30 ? fileName.count - 30 : 0
        let showedName = fileName.charactersArray[startFrom..<fileName.count]
        return String(showedName)
    }
}

extension ImagePicker {
    func emitImageInfo(_ receivedImage: PublishSubject<(String?, UIImage?)>, _ picker: UIImagePickerController,
                       didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        var pickedImageName: URL!
        if let data = image?.pngData() {
            let path = "\(String.random(ofLength: 35)).png"
            pickedImageName = getDocumentsDirectory().appendingPathComponent(path)
            try? data.write(to: pickedImageName)
        }
        let fileUrl = info[.imageURL] as? URL
        let name = fileUrl?.lastPathComponent.attachName() ?? pickedImageName.lastPathComponent.attachName()
        receivedImage.onNext((name, image?.apiSize()))
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//
//  ImagePickerView.swift
//  Direct
//
//  Created by abuzeid on 6/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift

class ImagePickerView: UIView, ImagePicker {
    var disposeBag = DisposeBag()
    var currentImageID: Int = 0
    
    var receivedImage = PublishSubject<(String?, UIImage?)>()
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        let fileUrl = info[.imageURL] as? URL
        receivedImage.onNext((fileUrl?.lastPathComponent, image?.apiSize()))
        picker.dismiss(animated: true, completion: nil)
    }
}

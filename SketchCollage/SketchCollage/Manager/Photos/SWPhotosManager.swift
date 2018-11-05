//
//  SWPhotosManager.swift
//  Oil
//
//  Created by liuhongli on 2018/8/27.
//  Copyright © 2018年 北京翔拓科技有限公司. All rights reserved.
//

import UIKit

/*
 传递选择图片的数组, 每次选择的图片变化后都要进行更新(一般是从cell中传递,例如: cell.photosManager.photos = photos)
 */

/// 传递一个图片数组的代理

protocol SWPhotosManagerDelegate {
    func sw_photos(_ photos: [UIImage], _ placeholderPhotos: [UIImage])
}

class SWPhotosManager: NSObject {
    var delegate: SWPhotosManagerDelegate?
    var placeholders = [UIImage]()

    var photos = [UIImage]() {
        didSet {
            let placeholder: UIImage = UIImage.init(named: "Add")!
            placeholders = photos
            placeholders.append(placeholder)
            delegate?.sw_photos(photos, placeholders)
        }
    }
}







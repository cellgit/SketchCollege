//
//  SWImagePickerManager.swift
//  CampusSafety
//
//  Created by shuwang on 2018/3/15.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//


/*
 相册管理的工具类
 */


import UIKit
import PKHUD

@objc protocol SWImagePickerManagerDelegate {
    /// 弹出 Sheet 面板
    func showActionSheet(actionSheet: UIAlertController)
    /// 打开相册
    @objc optional func openAlbumAction(picker: UIImagePickerController)
    /// 打开相机
    @objc optional func openCameraAction(picker: UIImagePickerController)
    /// 选择的照片
    @objc optional func selectedPhotos(picker: UIImagePickerController, photos: [UIImage])
}
protocol SWImagePickerManagerProtocol {
    func actionSheetAction()
}

class SWImagePickerManager: NSObject {
    var delegate : SWImagePickerManagerDelegate?
    var actionSheet:UIAlertController!
    var selectedPhotos = [UIImage]()
    
    func actionSheetAction() {
        self.actionSheet = UIAlertController(
            title: "",
            message: "",
            preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: "相机",
                                         style: UIAlertAction.Style.default,
                                         handler: {(paramAction:UIAlertAction!) in
                                            self.openCamera()
        })
        let actionPhoto = UIAlertAction(title: "相册",
                                        style: UIAlertAction.Style.default,
                                        handler: {(paramAction:UIAlertAction!) in
                                            self.openAlbum()
        })
        let actioncancel = UIAlertAction(title: "取消",
                                         style: UIAlertAction.Style.destructive,
                                         handler: {(paramAction:UIAlertAction!) in
                                            
        })
        actionSheet!.addAction(actionCamera)
        actionSheet!.addAction(actionPhoto)
        actionSheet!.addAction(actioncancel)
        
        delegate?.showActionSheet(actionSheet: actionSheet)
    }
}

//调用相机相册
extension SWImagePickerManager: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    //选择图片成功后代理
    private func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [String :Any]) {
        //获取选择的原图
        let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
        if !selectedPhotos.isEmpty {
            selectedPhotos.removeAll()
        }
        selectedPhotos.append(image)
        
        print("selectedPhotos=== \(selectedPhotos.count)")
        print("selectedPhotos2=== \(selectedPhotos)")
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
        
        if picker.sourceType == UIImagePickerController.SourceType.camera {
            var photos = [UIImage]()
            photos.append(image)
            delegate?.selectedPhotos!(picker: picker, photos: photos)
        }
    }
    
    func openAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            //弹出控制器，显示界面
            delegate?.openAlbumAction!(picker: picker)
        }else{
            print("读取相册错误")
        }
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.delegate = self
            //设置来源
            picker.sourceType = UIImagePickerController.SourceType.camera
            //允许编辑
            picker.allowsEditing = true
            //打开相机
            delegate?.openCameraAction!(picker: picker)
            
        }else{
            print("找不到相机")
        }
    }
}


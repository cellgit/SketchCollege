//
//  SWCommentViewController.swift
//  HouseRent
//
//  Created by liuhongli on 2018/11/1.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit


struct SWCommentStruct {
    var identifier = "" // 控制器标识符
//    var identifier = "" // 例如:服务的 id
//    var title = ""
    var dict = [String:String]()
}

class SWCommentViewController: UIViewController {
    
    var containerView: SWCommentView!
    var presenter: SWCommentPresenter!
    var params = SWCommentStruct()
    
    
    var imagePickerManager : SWImagePickerManager!  // 相册相机管理类
    var showingPhotos = [UIImage]()
    
    
    convenience init(params: SWCommentStruct) {
        self.init()
        self.params = params
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = self.params.title
        self.title = self.params.dict["title"] ?? ""
        
        setupUI()
        setupImagePickerManager()
        addNotification()
        
        commitBtnSettings()
    }
    
    func addNotification() {
        /// 添加观察者
        NotificationCenter.default.addObserver(self, selector: #selector(openPhotosLirary) , name: SWNotificationHelper.SWOpenPhotosLibraryNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(previewPhotosNotification(noti:)), name: SWNotificationHelper.SWPreviewImagePhotosNotification, object: nil)
        /// 删除照片后更新cell布局
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableViewConstrains(noti:)) , name: SWNotificationHelper.SWUpdateConstrainsNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(photosShowingChanged(noti:)) , name: SWNotificationHelper.SWPhotosShowingChangedNotification, object: nil)
    }
    @objc func openPhotosLirary() {
        imagePickerManager.actionSheetAction()
    }
    @objc func previewPhotosNotification(noti: Notification) {
//        let params = noti.object as! SWPreviewPhotosStruct
//        self.skimPhotos(params)
    }
    @objc func updateTableViewConstrains(noti: Notification) {
        let params = noti.object as! SWPreviewPhotosStruct
        if containerView.tableView != nil {
            containerView.photos.removeAll()
            containerView.photos = params.photos
            containerView.tableView.reloadData()
        }
    }
    @objc func photosShowingChanged(noti: Notification) {
        let params = noti.object as! SWPreviewPhotosStruct
        showingPhotos = params.photos
        self.containerView.commitPhotos = params.photos
    }
    //// 相册设置
    func openAlbum() {
        imagePickerManager.actionSheetAction()
    }
    // 实例化相册管理类并设置代理
    func setupImagePickerManager() {
        imagePickerManager = SWImagePickerManager.init()
        imagePickerManager.delegate = self
    }

    
    func setupUI() {
        let containerView = SWCommentView.init(frame: self.view.frame, vc: self)
        containerView.vc = self
        self.view.addSubview(containerView)
        self.containerView = containerView
        self.containerView.delegate = self
        
        self.presenter = SWCommentPresenter.init(SWUploadImageModel(), containerView)
    }

}


extension SWCommentViewController {
    func uploadimages() {
        let imgParams = SWUploadImagesStruct.init()
        let content: String = imgParams.dict["content"] ?? ""
        var dict = ["":""]
        var urlStr = ""
        
        dict = ["content": content]
        urlStr = APIManager.baseUrl + "/xfAppServerMakeController.do?myMake"
        let params = SWNetworkParamsStruct.init(url: urlStr, dict: dict)
        print("===== \(params)")
        
        self.presenter.gotoRequestData(params: params, imgParams: imgParams.photos)
    }
    
}


extension SWCommentViewController: SWImagePickerManagerDelegate {
    func showActionSheet(actionSheet: UIAlertController) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    func openAlbumAction(picker: UIImagePickerController) {
//        let photoSelector = GWLPhotoLibrayController(block: { (images) in
//            if let imgArr = images as? [UIImage]{
//                if self.containerView.tableView != nil {
//                    self.containerView.photos.removeAll()
//                    self.containerView.photos = imgArr
//                    self.containerView.tableView.reloadData()
//                }
//            }
//        })
//        photoSelector?.maxCount = self.showingPhotos.count == 0 ? 9 : 9 - self.showingPhotos.count
//        photoSelector?.multiAlbumSelect = true
//        self.present(photoSelector!, animated: true, completion: nil)
    }
    func openCameraAction(picker: UIImagePickerController) {
        self.present(picker, animated: true, completion: { () -> Void in
        })
    }
    func selectedPhotos(picker: UIImagePickerController, photos: [UIImage]) {
        self.containerView.photos = photos
    }
}

/// 照片预览
//extension SWCommentViewController {
//    func skimPhotos(_ params: SWPreviewPhotosStruct) {
//        // 1. create SKPhoto Array from UIImage
//        var images = [SKPhoto]()
//        for item in params.photos {
//            let photo = SKPhoto.photoWithImage(item)
//            images.append(photo)
//        }
//        // 2. create PhotoBrowser Instance, and present from your viewController.
//        let browser = SKPhotoBrowser(photos: images)
//        browser.initializePageIndex(params.index)
//        present(browser, animated: true, completion: {})
//    }
//}







//ZXAskQuestionViewController

extension SWCommentViewController {
    func commitBtnSettings() {
//        if self.params.id == "SWToCommentId" {
        if self.params.identifier == "SWToCommentId" {
            
            
            let bottomView = UIView.init()
            self.view.addSubview(bottomView)
            
            let btn = UIButton.init(type: .custom)
            bottomView.addSubview(btn)
            btn.layer.cornerRadius = 5
            btn.clipsToBounds = true
            btn.backgroundColor = SWColor.yellow
            btn.setTitle("发布", for: .normal)
            btn.action { (sender) in
                print("发布")
                self.commitReq()
            }
            bottomView.snp.makeConstraints { (make) in
                make.left.bottom.right.equalTo(self.view)
                make.height.equalTo(64)
            }
            btn.snp.makeConstraints { (make) in
                make.left.equalTo(bottomView.snp.left).offset(24)
                make.right.equalTo(bottomView.snp.right).offset(-24)
                make.center.equalTo(bottomView)
                make.height.equalTo(38)
            }
        }
    }
    
    func commitReq() {
        /// 发布的请求处理
        self.containerView.commitInfo()
    }
}
extension SWCommentViewController: SWUploadImagesDelegate {
    func sw_upload_images_action(commitParams: SWUploadImagesStruct) {
        
        let content: String = commitParams.dict["content"] ?? ""
        var dict = ["":""]
        var urlStr = ""
        //userid  serverinfoid  content file   scores
        let userid = ""//UserInfo?.userId ?? ""
//        let serverinfoid = commitParams.dict["serverinfoid"]
        let scores = commitParams.dict["score"] ?? "5"
        
        let serverid = self.params.dict["serverid"] ?? ""
        
        
//        dict = ["userid":userid,
//                "serverinfoid":self.params.identifier,
//                "content":content,
//                "scores":scores]
        
        dict = ["userid":userid,
                "serverinfoid":serverid,
                "content":content,
                "scores":scores]
//        APIManager.baseURLString = "http://192.168.0.110:8080/jeecg"
        urlStr = APIManager.baseUrl + "/xfAppServerComController.do?addEvaluation"
        let params = SWNetworkParamsStruct.init(url: urlStr, dict: dict)
        print("===== \(params)")
        self.presenter.gotoRequestData(params: params, imgParams: commitParams.photos)
    }
}




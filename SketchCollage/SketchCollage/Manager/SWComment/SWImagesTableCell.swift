//
//  SWImagesTableCell.swift
//  HouseRent
//
//  Created by liuhongli on 2018/11/1.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit
import PKHUD

struct SWPreviewPhotosStruct {
    /// 需要预览的照片
    var photos = [UIImage]()
    /// 点击选中的照片索引
    var index: Int = 0
}

struct SWPreviewPhotosUrlStruct {   // 预览url的照片
    /// 需要预览的照片
    var photos = [String]()
    /// 点击选中的照片索引
    var index: Int = 0
}

class SWImagesTableCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionHeightConst: NSLayoutConstraint!
    
    let KUICollectionViewCell = "UICollectionViewCell"
    
    lazy var flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let titleHeight: CGFloat = 40   // type.titleLabel的height
    var photosManager: SWPhotosManager!
    
    /// 显示的照片
    var showPhotos = [UIImage]() {
        didSet {
            let params = SWPreviewPhotosStruct.init(photos: showPhotos, index: 0)
            NotificationCenter.default.post(name: SWNotificationHelper.SWPhotosShowingChangedNotification, object: params, userInfo: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.backgroundColor = UIColor.white
        setupCollectionView()
        setupUI()
        reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //加载数据
    func reloadData() {
        //设置标题
        //collectionView重新加载数据
        self.collectionView.reloadData()
        
        //更新collectionView的高度约束
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        collectionHeightConst.constant = contentSize.height
        //        if self.photoArray.isEmpty {
        //            collectionViewConst.constant = 0
        //        }
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupUI() {
        photosManager = SWPhotosManager.init()
        photosManager.delegate = self
    }
    
    func getItemSize() -> (width:CGFloat, height:CGFloat) {
        let scale: CGFloat = 1.0
        let itemWidth = (AppWidth - 70.0) / 3.0
        let itemHeight:CGFloat = itemWidth * scale
        return(itemWidth,itemHeight)
    }
    
    func setupCollectionView() {
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let itemWidth:CGFloat = getItemSize().width
        let itemHeight:CGFloat = getItemSize().height
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.isScrollEnabled = false
        collectionView.scrollIndicatorInsets = (collectionView?.contentInset)!
        
        collectionView.alwaysBounceVertical = true
        self.contentView.addSubview(collectionView!)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photosManager != nil {
            return showPhotos.count + 1
        }
        else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        /// 打开相册
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            ///限制照片数量
            if showPhotos.count >= 5 {
                HUD.flash(.label("最多上传5张图片"), delay: 1.0)
                return
            }
            print("打开相册")
            /// 通知打开相册
            NotificationCenter.default.post(name: SWNotificationHelper.SWOpenPhotosLibraryNotification, object: nil)
        }
        else {
            /// 预览所选照片
            let params = SWPreviewPhotosStruct.init(photos: showPhotos, index: indexPath.item)
            NotificationCenter.default.post(name: SWNotificationHelper.SWPreviewImagePhotosNotification, object: params, userInfo: nil)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = SWCellReuseIdentifier.shared.cellReuseId(cell: KUICollectionViewCell, section: indexPath.section, row: indexPath.row)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let imgView:UIImageView = UIImageView()
        imgView.contentMode = .scaleToFill
        cell.tag = indexPath.item
        
        cell.contentView.addSubview(imgView)
        
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            imgView.image = UIImage(named: "compose_pic_add")
        }
        else {
            imgView.image = showPhotos[indexPath.item]
        }
        
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleToFill
        imgView.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        
        if indexPath.row != collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            let deleteBtn = UIButton.init(type: .custom)
            
            /// 删除图片的按钮
            deleteBtn.isHidden = false     // true,为隐藏删除, false: 显示删除按钮
            cell.contentView.addSubview(deleteBtn)
            deleteBtn.setImage(UIImage.init(named: "close"), for: .normal)
            deleteBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 0)
            deleteBtn.tag = indexPath.row
            deleteBtn.action { (sender) in
                print("删除照片")
                self.showPhotos.remove(at: sender.tag)
                var lastPhotos = [UIImage]()
                for item in self.showPhotos {
                    lastPhotos.append(item)
                }
                self.showPhotos.removeAll()
                /// 发送通知,更新tableviewcell的布局
                let params = SWPreviewPhotosStruct.init(photos: lastPhotos, index: sender.tag)
                NotificationCenter.default.post(name: SWNotificationHelper.SWUpdateConstrainsNotification, object: params, userInfo: nil)
            }
            deleteBtn.snp.makeConstraints { (make) in
                make.top.equalTo(cell.snp.top)
                make.right.equalTo(cell.snp.right)
                make.width.height.equalTo(30)
            }
        }
        
        imgView.snp.makeConstraints({ (make) in
            make.edges.equalTo(cell.contentView)
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return flowLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        return UICollectionReusableView.init()
    }

}

extension SWImagesTableCell: SWPhotosManagerDelegate {
    func sw_photos(_ photos: [UIImage], _ placeholderPhotos: [UIImage]) {
        print("photos==== \(photos), placeholderPhotos===== \(placeholderPhotos)")

        for item in photos {
            showPhotos.append(item)
        }
        reloadData()
    }
}

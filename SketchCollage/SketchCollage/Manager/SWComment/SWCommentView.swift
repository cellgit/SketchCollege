
//
//  SWCommentView.swift
//  HouseRent
//
//  Created by liuhongli on 2018/11/1.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit
import PKHUD

/// UITextView自定义代理
protocol SWUploadImagesDelegate {
    func sw_upload_images_action(commitParams: SWUploadImagesStruct)
}

struct SWUploadImagesStruct {
    var dict = [String:String]()
    var photos = [UIImage]()
}

//protocol SWCommitDelegate {
//    func sw_commit_action(commitParams: SWCommitStruct)
//}

//struct SWCommitStruct {
//    var score: String
//    /// 服务信息id或其他的id
//    var serverid: String
//    var userid: String
//    var content: String
//    var imgs: [UIImage]
//}

class SWCommentView: UIView {

    var vc: SWCommentViewController!
    let KSWCommentTitleCell = "SWCommentTitleCell"
    let KSWTextViewCell = "SWTextViewCell"
    let KSWImagesTableCell = "SWImagesTableCell"
    var tableView: UITableView!
    let rowCount: Int = 3   // tableView 行数
    
    
    var score: String = ""
    var commitPhotos = [UIImage]()    // 确认最终提交的图片
    var commitContent = ""            // 最终提交的文字内容
    
    var delegate: SWUploadImagesDelegate!
    
    var isSelectedScore: Bool = false
    
    
    
    public var photos = [UIImage]() {
        didSet {
            if tableView != nil {
                self.tableView.reloadData()
            }
        }
    }
    
    convenience init(frame: CGRect, vc: SWCommentViewController) {
        self.init()
        self.frame = frame
        self.vc = vc
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setTable(){
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight - NavigationH), style: .plain)
        self.addSubview(tableView)
        
        tableView.showsVerticalScrollIndicator = false
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {}
        let arrayM = [KSWCommentTitleCell,
                      KSWTextViewCell,
                      KSWImagesTableCell]
        for str in arrayM {
            self.tableView!.register(UINib(nibName:str, bundle:nil), forCellReuseIdentifier:str)
        }
        tableView.delegate = self
        tableView.dataSource = self
        
    }


}

extension SWCommentView: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > rowCount - 1 {
            return UITableViewCell.init()
        }
        if indexPath.row == 0 {
            let cell: SWCommentTitleCell = tableView.dequeueReusableCell(withIdentifier: KSWCommentTitleCell, for: indexPath) as! SWCommentTitleCell
            cell.delegate = self
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1 {
            let cell: SWTextViewCell = tableView.dequeueReusableCell(withIdentifier: KSWTextViewCell, for: indexPath) as! SWTextViewCell
            cell.delegate = self
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 2 {
            let cell: SWImagesTableCell = tableView.dequeueReusableCell(withIdentifier: KSWImagesTableCell, for: indexPath) as! SWImagesTableCell
            cell.photosManager.photos = photos
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        else {
            return UITableViewCell.init()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

/// 获取需要提交的文字
extension SWCommentView: SWEndEditDelegate {
    func sw_edit_result_action(text: String) {
        self.commitContent = text
        print("text ======== \(text)")
    }
}

extension SWCommentView: SWCommentTitleDelegate {
    func sw_score_action(score: String) {
        isSelectedScore = true
        self.score = score
    }
}



extension SWCommentView {
    func commitInfo () {
        if self.score == "" {
            self.score = "5"
        }
        let dict = ["content":self.commitContent,
                    "scores":self.score]
        let params = SWUploadImagesStruct.init(dict: dict, photos: commitPhotos)
        delegate.sw_upload_images_action(commitParams: params)
    }
}

extension SWCommentView: SWViewUnparseProtocol {
    func showViewUnparse(data: SWSucceedParamsStruct<Any>) {
        print("发布结果")
        if data.json["code"].stringValue == "0" {
            HUD.flash(.label("发布评价成功"), delay: 1.0)
            self.vc.navigationController?.popViewController(animated: true)
        }
        else {
            HUD.flash(.label("发布失败"), delay: 1.0)
        }
    }
}




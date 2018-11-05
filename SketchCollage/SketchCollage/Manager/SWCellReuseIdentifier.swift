//
//  SWCellReuseIdentifier.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/7/28.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

/// 利用随机数注册cell,避免复用
class SWCellReuseIdentifier: NSObject {
    static let shared:SWCellReuseIdentifier = SWCellReuseIdentifier()
    
    /*
     usage:
     在cellForRowAt方法中注册cell, xib注册使用方法
     let reuseId =  SWCellReuseIdentifier.shared.cellReuseId(cell: "SWResumeCell", section: indexPath.section, row: indexPath.row)
     self.tableView!.register(UINib(nibName:KMyCouponCell, bundle:nil), forCellReuseIdentifier: reuseId)
     let cell :SWResumeCell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! SWResumeCell
     */
    /// 获取注册所需的随机id
    func cellReuseId(cell: String, section: Int, row: Int) -> String {
        /// 随机数注册cell
        let randomNumber:Int = Int(arc4random_uniform(1000000000))
        let reuseId = "\(randomNumber)K\(cell)\(section)\(row)"
        return reuseId
    }

}

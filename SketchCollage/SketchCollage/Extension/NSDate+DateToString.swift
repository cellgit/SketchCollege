//
//  NSDate+DateToString.swift
//  Oil
//
//  Created by shuwang on 16/7/29.
//  Copyright © 2016年 北京翔拓科技有限公司. All rights reserved.
//

import UIKit

extension Date{
    //时间戳转有格式时间
    static func timeStampToBaseStr(_ timeStamp:String, dataStyle: String )->String {
        
        let string = NSString(string: timeStamp)
        let timeSta:Foundation.TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dataStyle
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //时间戳转有格式时间
    static func timeStampToString(_ timeStamp:String, dataStyle: String )->String {
      
        let string = NSString(string: timeStamp)
        let timeSta:Foundation.TimeInterval = string.doubleValue / 1000
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dataStyle
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    //时间戳转时间
    static func timeStampToString(_ timeStamp:String) -> Date {
        
        let string = NSString(string: timeStamp)
        let timeSta:Foundation.TimeInterval = string.doubleValue / 1000
        let date = Date(timeIntervalSince1970: timeSta)
        
        return date
    }

    
    //获取日期差，yyyy-MM-dd HH:mm:ss格式
    
    static func intervalSinceNow(_ fromdate: Date) -> String{
         let format = DateFormatter.init()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fromZone = TimeZone.current
        let fromInterval = fromZone.secondsFromGMT(for: fromdate)
        let fromDate = fromdate.addingTimeInterval(Double(fromInterval))
        
        let adate = Date()
        let zone = TimeZone.current
        let interval = zone.secondsFromGMT(for: adate)
        let localeDate = adate.addingTimeInterval(Double(interval))
        
        let interValTime = fromDate.timeIntervalSinceReferenceDate - localeDate.timeIntervalSinceReferenceDate
        let lTime = fabs(interValTime)
        let iSeconds = Int(lTime.truncatingRemainder(dividingBy: 60))
        let iMinutes = Int((lTime / 60).truncatingRemainder(dividingBy: 60))
        let iHours = Int(fabs((lTime / 3600).truncatingRemainder(dividingBy: 24)))
        let iDays: Int = Int(lTime / 60 / 60 / 24)
        
        var timeString = ""
        if interValTime <= 0{
            timeString = "本课程已截止报名！"
        }else{
            if iDays != 0 {
                timeString = "距离报名截止时间还有：" + String(iDays) + "天" + String(iHours) + "小时" + String(iMinutes) + "分" + String(iSeconds) + "秒"
            }else if iHours != 0 {
                timeString = "距离报名截止时间还有：" + String(iHours) + "小时" + String(iMinutes) + "分" + String(iSeconds) + "秒"
            }
        }
        
        return timeString

    }
}

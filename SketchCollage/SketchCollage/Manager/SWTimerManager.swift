//
//  SWTimerManager.swift
//  CampusSafety
//
//  Created by liuhongli on 2018/3/28.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

/*
 注：使用方法
 传入参数（枚举）：SWDateFormat.Year 或 SWDateFormat.Month等，显示不同样式
 
 class ViewController: UIViewController{
 let timerManager = SWTimerManager()
 
 用法一：获取当前时间
 let currentTime:String = self.timerManager.getCurrentTime(dateFormat: SWDateFormat.Year)
 或者：let currentTime: String = SWTimerManager.shared.getCurrentTime(dateFormat: SWDateFormat.YearToDay)
 
 用法二：实时显示当前时间
 func createTimer() {
 timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
 if self.timeLabel != nil {
 // 实时显示当前时间
 self.timeLabel.text = self.timerManager.getCurrentTime(dateFormat: SWDateFormat.Year)
 }
 })
 }
 }
 或者 单例
 
 用法三：指定时间格式转换：传入时间戳的字符串即可
 func dateFormat(timeStamp:String) -> String {
 let formatTime:String = timerManager.getFormatTime(dateFormat: SWDateFormat.Hour, timeStamp: timeStamp)
 return formatTime
 }
 let formatTime:String = dateFormat(timeStamp: (attendanceModel?.now_time)!)
 formatTime 即为转化后的时间格式
 或者 单例
 
 
 用法四: 如果时间戳为13位字符串,则需要去掉最后三位,
    1>可以转换成CGFloat,然后除 1000,再转换成String
    2>或者直接截取前10位
 这里直接截取前10位的用法如下:
 let classModel: MyStudyClassDetailModel = classDetailArray[indexPath.row]
 let curriculaTimeStr = classModel.curriculaTime.subString(start: 0, length: 10)
 let curriculaTime: String = SWTimerManager.shared.getFormatTime(dateFormat: SWDateFormat.TimYearToDay, timeStamp: String(describing: curriculaTimeStr))
 cell.titleLabel.text = "开课时间: \(curriculaTime)"
 
 */

import UIKit

extension SWTimerManager {
    /// "当前"时间获取: 2018年01月01日 或 2018-01-01
    open func getCurrentTime(dateFormat:SWDateFormat) -> String {
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let currentTime:String = getTime(dateFormat: dateFormat, timeInterval: timeInterval)
        return currentTime
    }
    /// "指定时间"格式转换: 2020年01月01日 或 2020-01-0
    open func getFormatTime(dateFormat:SWDateFormat, timeStamp: String) -> String {
        let timeInterval = TimeInterval(timeStamp)
        
        guard timeInterval != nil else { return "" }
        
        let formatTime:String = getTime(dateFormat: dateFormat, timeInterval: timeInterval!)
        return formatTime
    }
    
    /// Date格式转换成时间戳格式（2018-04-11 06:49:52 +0000 -> 17777777777）
    func getStampFormat(date: Date) -> String {
        let timeInterval:TimeInterval = date.timeIntervalSince1970
        let timeStamp = String(timeInterval)
        return timeStamp
    }
}

enum SWDateFormat {
    case Year           // yyyy年MM月dd日 HH:mm:ss
    case Month          // MM月dd日 HH:mm:ss
    case Day            // dd日 HH:mm:ss
    case Hour           // HH:mm:ss
    case Minute         // mm:ss
    case Second         // ss
    case YearToYear     // yyyy年
    case YearToMonth    // yyyy年MM月
    case YearToDay      // yyyy年MM月dd日
    case YearToHour     // yyyy年MM月dd日 HH时
    case YearToMinute   // yyyy年MM月dd日 HH:mm
    case MonthToMonth   // MM月
    case MonthToDay     // MM月dd日
    case MonthToHour    // MM月dd日 HH时
    case MonthToMinute  // MM月dd日 HH:mm
    case DayToDay       // dd日
    case DayToHour      // dd日 HH时
    case DayToMinute    // dd日 HH:mm
    case HourToHour     // HH
    case HourToMinute   // HH:mm
    case MinuteToMinute // mm
    
    case TimYear           // yyyy-MM-dd HH:mm:ss
    case TimMonth          // MM-dd HH:mm:ss
    case TimDay            // dd HH:mm:ss
    case TimYearToYear     // yyyy
    case TimYearToMonth    // yyyy-MM
    case TimYearToDay      // yyyy-MM-dd
    case TimYearToHour     // yyyy-MM-dd HH
    case TimYearToMinute   // yyyy-MM-dd HH:mm
    case TimMonthToMonth   // MM
    case TimMonthToDay     // MM-dd
    case TimMonthToHour    // MM-dd HH
    case TimMonthToMinute  // MM-dd HH:mm
    case TimDayToDay       // dd
    case TimDayToHour      // dd HH
    case TimDayToMinute    // dd日 HH:mm
    
    case TimeStamp      // 时间戳
}

class SWTimerManager: NSObject {
    static let shared:SWTimerManager = SWTimerManager()
    
//    static func shared() -> SWTimerManager {
//        let instance = SWTimerManager()
//        return instance
//    }
    
    func getTime(dateFormat:SWDateFormat, timeInterval:TimeInterval) -> String {
        //获取当前时间
//        let now = Date()
        //日期格式器
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        //当前时间的时间戳
//        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)   // 注意时间戳以秒为单位的
        //转换为时间
        let date = Date(timeIntervalSince1970: timeInterval)
        switch dateFormat {
        case SWDateFormat.Year:
            dateformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        case SWDateFormat.Month:
            dateformatter.dateFormat = "MM月dd日 HH:mm:ss"
        case SWDateFormat.Day:
            dateformatter.dateFormat = "dd日 HH:mm:ss"
        case SWDateFormat.Hour:
            dateformatter.dateFormat = "HH:mm:ss"
        case SWDateFormat.Minute:
            dateformatter.dateFormat = "mm:ss"
        case SWDateFormat.Second:
            dateformatter.dateFormat = "ss"
        case SWDateFormat.YearToYear:
            dateformatter.dateFormat = "yyyy年"
        case SWDateFormat.YearToMonth:
            dateformatter.dateFormat = "yyyy年MM月"
        case SWDateFormat.YearToDay:
            dateformatter.dateFormat = "yyyy年MM月dd"
        case SWDateFormat.YearToHour:
            dateformatter.dateFormat = "yyyy年MM月dd日 HH时"
        case SWDateFormat.YearToMinute:
            dateformatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        case SWDateFormat.MonthToMonth:
            dateformatter.dateFormat = "MM月"
        case SWDateFormat.MonthToDay:
            dateformatter.dateFormat = "MM月dd日"
        case SWDateFormat.MonthToHour:
            dateformatter.dateFormat = "MM月dd日 HH时"
        case SWDateFormat.MonthToMinute:
            dateformatter.dateFormat = "MM月dd日 HH:mm"
        case SWDateFormat.DayToDay:
            dateformatter.dateFormat = "dd日"
        case SWDateFormat.DayToHour:
            dateformatter.dateFormat = "dd日 HH时"
        case SWDateFormat.DayToMinute:
            dateformatter.dateFormat = "dd日 HH:mm"
        case SWDateFormat.HourToHour:
            dateformatter.dateFormat = "HH"
        case SWDateFormat.HourToMinute:
            dateformatter.dateFormat = "HH:mm"
        case SWDateFormat.MinuteToMinute:
            dateformatter.dateFormat = "mm"
            
        case SWDateFormat.TimYear:
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case SWDateFormat.TimMonth:
            dateformatter.dateFormat = "MM-dd HH:mm:ss"
        case SWDateFormat.TimDay:
            dateformatter.dateFormat = "dd HH:mm:ss"
        case SWDateFormat.TimYearToYear:
            dateformatter.dateFormat = "yyyy"
        case SWDateFormat.TimYearToMonth:
            dateformatter.dateFormat = "yyyy-MM"
        case SWDateFormat.TimYearToDay:
            dateformatter.dateFormat = "yyyy-MM-dd"
        case SWDateFormat.TimYearToHour:
            dateformatter.dateFormat = "yyyy-MM-dd HH"
        case SWDateFormat.TimYearToMinute:
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm"
        case SWDateFormat.TimMonthToMonth:
            dateformatter.dateFormat = "MM"
        case SWDateFormat.TimMonthToDay:
            dateformatter.dateFormat = "MM-dd"
        case SWDateFormat.TimMonthToHour:
            dateformatter.dateFormat = "MM-dd HH"
        case SWDateFormat.TimMonthToMinute:
            dateformatter.dateFormat = "MM-dd HH:mm"
        case SWDateFormat.TimDayToDay:
            dateformatter.dateFormat = "dd"
        case SWDateFormat.TimDayToHour:
            dateformatter.dateFormat = "dd HH"
        case SWDateFormat.TimDayToMinute:
            dateformatter.dateFormat = "dd HH:mm"
            
        default:
            dateformatter.dateFormat = String(timeStamp)
        }
        let timeString:String = dateformatter.string(from: date)
        return timeString
    }
}








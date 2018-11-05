//
//  SWGlobalConfig.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/24.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import Foundation
import UIKit


struct SWColor {
    /// #EEEEEE || RGB(238,238,238)
    static let theme = UIColor.init(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    
    /// #FEAC2C || RGB(254, 172, 44)
    static let yellow = UIColor.init(red: 254.0 / 255.0, green: 172.0 / 255.0, blue: 44.0 / 255.0, alpha: 1.0)
    
    /// #04AA9A || RGB(4, 170, 154)
    static let green = UIColor.init(red: 4.0 / 255.0, green: 170.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
    
    /// #FF7314 || RGB(255, 115, 20)
    static let orange = UIColor.init(red: 255.0 / 255.0, green: 115.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)
    
    /// #772425 || RGB(119, 36, 37)
    static let red = UIColor.init(red: 119.0 / 255.0, green: 36.0 / 255.0, blue: 37.0 / 255.0, alpha: 1.0)
    
    /// #EEEEEE || RGB(238, 238, 238)
    static let line = UIColor.init(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    
    /// #F9F9F9 || RGB(249, 249, 249)
    static let light = UIColor.init(red: 249.0 / 255.0, green: 249.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
    
    /// #F2F2F2 || RGB(242, 242, 242)
    static let cellGrouped = UIColor.init(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    
    /// #999999 || RGB(153,153,153)
    static let lightGray = UIColor.init(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
    
    /// #666666 || RGB(102,102,102)
    static let gray = UIColor.init(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    
    /// #333333 || RGB(52,52,52)
    static let darkGray = UIColor.init(red: 52.0 / 255.0, green: 52.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
}

struct SWSize {
    /// 30 : CGFloat
    static let navBarHeightIncrease: CGFloat = 30
    
    /// 屏幕宽度 : CGFloat
    static let appWidth: CGFloat = UIScreen.main.bounds.size.width
    
    /// 屏幕高度 : CGFloat
    static let appHeight: CGFloat = UIScreen.main.bounds.size.height
    
    /// 屏幕 bounds : CGFloat
    static let appSize: CGRect = UIScreen.main.bounds
    
    /// tabBar 高度
    static let tabBarHeight: CGFloat = UIScreen.main.bounds.size.height == 812 ? 83 : 49
    
    /// navigationBar 高度
    static let navBarHeight: CGFloat = UIScreen.main.bounds.size.height == 812 ? 88 : 64
}


//let SWColorDarkGray = UIColor.init(red: 52.0 / 255.0, green: 52.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
//let SWColorMiddleGray = UIColor.init(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
//let SWColorLightGray = UIColor.init(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
//let SWColorBrown = UIColor.init(red: 119.0 / 255.0, green: 36.0 / 255.0, blue: 37.0 / 255.0, alpha: 1.0)


public let NavigationBarHeightIncrease: CGFloat = 30
public let AppWidth: CGFloat = UIScreen.main.bounds.size.width
public let AppHeight: CGFloat = UIScreen.main.bounds.size.height
public let AppSize: CGRect = UIScreen.main.bounds
public let TabarHeight : CGFloat = UIScreen.main.bounds.size.height == 812 ? 83 : 49
public let NavigationH: CGFloat = UIScreen.main.bounds.size.height == 812 ? 88 : 64

public let ThemeColor = UIColor(red:238/255, green:238/255, blue:238/255, alpha:1.00)
public let YellowColor = UIColor(red:254/255, green:172/255, blue:44/255, alpha:1.00)
public let GreenColor = UIColor(red:4/255, green:170/255, blue:154/255, alpha:1.00)
public let OrangeColor = UIColor(red:255/255, green:115/255, blue:20/255, alpha:1.00)
public let RedColor = UIColor(red:119/255, green:36/255, blue:37/255, alpha:1.00)
public let LineColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.00)
public let lightColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.00)

/// 是否从第三方支付返回到应用的判断: false否, true是
var isBackedWallet: Bool = false






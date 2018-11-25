//
//  UserInfoModel.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/25.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class UserInfoModel: NSObject,NSCoding  {
    
    /// 用户id
    var userId : String = ""
    /// 注册手机号
    var phone : String = ""
    /// token
    var token : String = ""
    /// 用户昵称
    var nickName : String = ""
    /// 业务员标志
    var salesmanflag : String = ""
    /// 禁用标志
    //    var disableflag : String = ""
    /// 用户头像
    var headimage : String = ""
    //    /// 删除标识(1代表是0代表否)
    //    var delflag : String = ""
    /// 身份标识(0代表个人，1代表机构)
    var sign : String = ""
    
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.userId, forKey: "userId")
        aCoder.encode(self.phone, forKey: "phone")
        aCoder.encode(self.token, forKey: "token")
        aCoder.encode(self.nickName, forKey: "nickName")
        aCoder.encode(self.salesmanflag, forKey: "salesmanflag")
        //        aCoder.encode(self.disableflag, forKey: "disableflag")
        aCoder.encode(self.headimage, forKey: "headimage")
        //        aCoder.encode(self.delflag, forKey: "delflag")
        aCoder.encode(self.sign, forKey: "sign")
    }
    required init(coder aDecoder: NSCoder){
        super.init()
        self.userId = aDecoder.decodeObject(forKey: "userId") as! String
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String
        self.token = aDecoder.decodeObject(forKey: "token") as! String
        self.nickName = aDecoder.decodeObject(forKey: "nickName") as! String
        self.salesmanflag = aDecoder.decodeObject(forKey: "salesmanflag") as! String
        //        self.disableflag = aDecoder.decodeObject(forKey: "disableflag") as! String
        self.headimage = aDecoder.decodeObject(forKey: "headimage") as! String
        self.sign = aDecoder.decodeObject(forKey: "sign") as! String
        //        self.delflag = aDecoder.decodeObject(forKey: "delflag") as! String
    }
    
    override init() {
        
    }
}

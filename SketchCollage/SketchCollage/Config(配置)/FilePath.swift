//
//  FilePath.swift
//  Oil
//
//  Created by shuwang on 16/8/24.
//  Copyright © 2016年 北京翔拓科技有限公司. All rights reserved.
//

import UIKit

class FilePath: NSObject {
    
    class func filePath(_ path: FileManager.SearchPathDirectory, senderPath: String?) -> String{
        if senderPath == ""{
            return ""
        }
      
        return NSSearchPathForDirectoriesInDomains(path, .userDomainMask, true)[0].appending(senderPath!)
    }
    
    class func isFileExistWithFilePath(filePath: String) -> Bool{
        if filePath == ""{
            return false
        }
        return FileManager.default.fileExists(atPath: filePath)
    }

}

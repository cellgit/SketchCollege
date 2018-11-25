//
//  FilePath.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/25.
//  Copyright © 2018 lhl. All rights reserved.
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

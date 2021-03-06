//
//  StringExtension.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/9.
//

import Foundation

extension NSString {
    var className : String? {

        let nameArray = self.components(separatedBy: ".")
        if let className = nameArray.last {
            return className
        }
        return nil
    }
}

extension String {
    //解码:把任何参数转换成适合放在URL中的字符串。
     func urlEncoded() -> String {
         let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
             .urlQueryAllowed)
         return encodeUrlString ?? ""
     }
  
     //将编码后的url转换回原始的url
     func urlDecoded() -> String {
         return self.removingPercentEncoding ?? ""
     }
}

extension String {
    
  
    
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
}

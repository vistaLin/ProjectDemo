//
//  RankRuleViewController.swift
//  HomeDoctorManager
//
//  Created by 林兴宽Mini on 2021/3/17.
//

import UIKit

class RankRuleViewController: BaseViewController {
    
    var phone:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "排行榜规则说明"
        setupUI()
    }
   
    
}

extension RankRuleViewController {
    func  setupUI() {
        
        let scrollView = UIScrollView.init()
        scrollView.frame = self.view.bounds
        scrollView.bounces = false
        view.addSubview(scrollView)
        
        let titleArray = ["一、排行榜主要展示各人群签约情况排行。", "二、排行统计规则：", "三、暂未填报数据：", "四、数据来源:", "五、特别说明:"]
        var str = ""
        if LoginViewModel.shared.selectLevel == 3 {
            str = "\n65岁以上老年人、孕产妇、0-6岁儿童、残疾人、高血压、糖尿病、精神障碍、结核病以签约人数进行排行。"
        }
        let contentArray = ["全人群、重点人群、建档立卡人群以签约率进行排行：\n 1、 全人群签约率=全人群签约数／区域人口总数*100% \n2、重点人群签约率=重点人群签约数／区域重点人群总数*100%（重点人群包括:65岁以上老年人、0-6岁童、孕产妇、残疾人、糖尿病、高血压、结核病和严重精神障碍患者）\n3、建档立卡人群签约率=建档立卡人群签约数／区域建档立卡人群总数*100%；\(str)", "相关机构负责人未在管理平台中完善数据，请通知相关负责人及时完善数据。", "中国家医医生端APP、居民端APP。", "若对排行榜数据有任何疑问，可联系客服专线\n4008-010-133进行反馈。"]
        var prefiexLabel:UILabel!
        for (index, value) in titleArray.enumerated() {
            let titleLabel = UILabel.init(fontSize: 0, colorHex: UIColor.defaultBlackHex, text: value)
            titleLabel.font = UIFont.semibold(16)
            titleLabel.numberOfLines = 0
            scrollView.addSubview(titleLabel)
            if index == 0 {
                titleLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(16)
                    make.top.equalTo(24)
                    make.width.equalTo(SizeHelper.screenWidth - 16 * 2)
                }
                prefiexLabel = titleLabel
            } else {
                titleLabel.snp.makeConstraints { (make) in
                    make.left.width.equalTo(prefiexLabel)
                    make.top.equalTo(prefiexLabel.snp.bottom).offset(16)
                }
                prefiexLabel = titleLabel
                
                let contentLabel = UILabel.init(fontSize: 14, colorHex: "#999999", text: contentArray[index - 1])
                contentLabel.setText(text: contentArray[index - 1], lineSpacing: 8)
                contentLabel.numberOfLines = 0
                scrollView.addSubview(contentLabel)
                contentLabel.snp.makeConstraints { (make) in
                    make.left.width.equalTo(prefiexLabel)
                    make.top.equalTo(prefiexLabel.snp.bottom).offset(16)
                }
                if index == titleArray.count - 1 {

                    contentLabel.snp.remakeConstraints { (make) in
                        make.left.width.equalTo(prefiexLabel)
                        make.top.equalTo(prefiexLabel.snp.bottom).offset(16)
                        make.bottom.equalTo(-20)
                    }
                    contentLabel.isUserInteractionEnabled = true
                    let tap = UITapGestureRecognizer.init(target: self, action: #selector(callPhoneAction))
                    contentLabel.addGestureRecognizer(tap)
                    self.setTextInfoToPhone(labInfo: contentLabel, WithText: contentArray[index - 1])
                }
                
                prefiexLabel = contentLabel
                
            }
        }
    }
    
    
    /** 设置信息，检测是否有有手机号。有则添加拨打电话事件 */
    func setTextInfoToPhone(labInfo:UILabel,WithText text:String){
        
        let stringRange:NSRange = NSRange.init(location: 0, length: NSString.init(string: text).length)
        
        //匹配号码
        let strRegex = "\\d{3,4}[-]?\\d{3,4}[-]?\\d{3,4}"
        
        let regexps:NSRegularExpression? = try! NSRegularExpression.init(pattern: strRegex, options: NSRegularExpression.Options(rawValue: 0))
        if regexps != nil {
            regexps?.enumerateMatches(in: text,
                                      options: NSRegularExpression.MatchingOptions.init(rawValue: 0),
                                      range: stringRange,
                                      using: { (result:NSTextCheckingResult?, flags:NSRegularExpression.MatchingFlags, _) in
                                        
                                        //可能为电话号码的字符串及其所在位置
                                        let phoneRange:NSRange = (result?.range)!
                                        phone = NSString.init(string: text).substring(with: phoneRange)
                                        
                                        let paragraphStyle = NSMutableParagraphStyle()
                                        paragraphStyle.lineSpacing = 8
                                        let attributeStriung:NSMutableAttributedString = NSMutableAttributedString(string: text)
                                        attributeStriung.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, text.count))
                                        
                                        //设置文本中的电话号码显示为蓝色
                                        //                                            let attributeStriung:NSMutableAttributedString = NSMutableAttributedString.init(string: text)
                                        
                                        let dicAttr:[NSAttributedString.Key:Any] = [
                                            NSAttributedString.Key.foregroundColor:UIColor.defaultMainColor,
                                            //  NSAttributedString.Key.underlineStyle:1,
                                            //                                                NSAttributedString.Key.paragraphStyle:paragraphStyle
                                        ]
                                        attributeStriung.addAttributes(dicAttr, range: phoneRange)
                                        
                                        labInfo.attributedText = attributeStriung
                                        
                                        //                                            //点击拨打电话
//                                        DispatchQueue.main.asyncAfter(deadline:.now() + 0.01) {
//                                            var phoneControl:UIControl? = labInfo.viewWithTag(1234) as? UIControl
//                                            if phoneControl == nil {
//                                                phoneControl = UIControl.init()
//
//                                                phoneControl?.frame = labInfo.frame
//
//                                                //                                                    phoneControl = UIControl.init(frame: labInfo.boundingRect(forCharacterRange: phoneRange))
//                                                phoneControl?.tag = 1234
//                                                phoneControl?.isUserInteractionEnabled = true
//
//                                                phoneControl?.addTarget(self, action: #selector(self.callPhoneAction), for: .touchUpInside)
//
//                                                labInfo.addSubview(phoneControl!)
//                                            }
//                                        }
                                        
                                      })
        }
        else{
            labInfo.text = text
        }
        
    }
    
    @objc func callPhoneAction()  {
        OpenUrlHelper.openTelphoneWithNumber(number: "4008-010-133", controller: self)
    }
}

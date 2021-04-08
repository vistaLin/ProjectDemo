//
//  UserProtocolViewController.swift
//  HomeDoctorManager
//
//  Created by Lennon on 2021/3/25.
//

import UIKit

class UserProtocolViewController: BaseViewController {
    let scrollView = UIScrollView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "用户协议"
        setupUI()
    }
}

extension UserProtocolViewController {
    func  setupUI() {
        scrollView.frame = self.view.bounds
        scrollView.bounces = false
        view.addSubview(scrollView)
        
        let titleLabel = UILabel.init(fontSize: 16, colorHex: UIColor.defaultGraykHex, text: "中国家庭医生签约信息服务平台")
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(32)
            make.centerX.equalToSuperview()
        }

        let titleArray = ["中国家庭医生签约信息服务平台（以下简称中国家医平台）是国家卫生计生委基层卫生司指导、《健康报》社主办的服务家庭医生和居民的信息平台。", "中国家医平台在此特别提醒用户认真阅读、充分理解本《服务协议》（下称《协议》）中各条款，包括免除或者限制中国家医平台责任的免责条款及对用户的权利限制条款。", "请您审慎阅读并选择接受或不接受本《协议》（未成年人应在法定监护人陪同下阅读）。除非您接受本《协议》所有条款，否则您无权注册、登录或使用本协议所涉相关服务。您的注册、登录、使用等行为将视为对本《协议》的接受，并同意接受本《协议》各项条款的约束。", "本《协议》适用于中国家医平台产品及服务，包括中国家医平台官网（域名为grdoc.org）、中国家医居民端、医生端、管理端（包括适配安卓、iOS，Mac以及windows的中国家医系列APP）。", "本《协议》是您（下称“用户”）与中国家医平台之间关于用户注册、登录、使用“中国家医平台”服务所订立的协议。本《协议》描述中国家医平台与用户之间关于“家庭医生签约”服务相关方面的权利义务。“用户”是指注册、登录、使用、浏览本服务平台的个人或组织。", "本《协议》可由中国家医平台随时更新，更新后的协议条款一旦公布即代替原来的协议条款，用户可在本网站查阅最新版协议条款。在修改《协议》条款后，如果用户不接受修改后的条款，请立即停止使用中国家医平台提供的服务，用户继续使用中国家医平台提供的服务将被视为已接受了修改后的协议。"]
        
        var prefiexLabel:UILabel!
        for (index, value) in titleArray.enumerated() {
            let tempLabel = getLabel(value: value)
            if index == 1 || index == 2 {
                tempLabel.textColor = UIColor.defaultBlockColor
            }
            if prefiexLabel == nil {
                tempLabel.snp.makeConstraints { (make) in
                    make.left.equalTo(16)
                    make.top.equalTo(titleLabel.snp.bottom).offset(24)
                    make.width.equalTo(SizeHelper.screenWidth - 16 * 2)
                }
                prefiexLabel = tempLabel
            } else {
                tempLabel.snp.makeConstraints { (make) in
                    make.left.width.equalTo(prefiexLabel)
                    make.top.equalTo(prefiexLabel.snp.bottom).offset(16)
                }
                prefiexLabel = tempLabel
                
            }
        }
     
        let subTitleArray = ["一、使用规则", "二、隐私保护", "三、法律责任及免责", "四、其他条款"]
        
        var contentArray: Array<Array<String>> = Array()
        contentArray.append(firstContentArray())
        contentArray.append(["用户同意个人隐私信息是指那些能够对用户进行个人辨识或涉及个人通信的信息，包括但不限于下列信息：用户真实姓名，身份证号，手机号码，IP地址。而非个人隐私信息是指用户对家庭医生签约服务的操作状态以及使用习惯等一些明确且客观反映在中国家医平台服务器端的基本记录信息和其他一切个人隐私信息范围外的普通信息；以及用户同意公开的上述隐私信息。", "尊重用户个人隐私信息的私有性是中国家医平台的基本制度，中国家医平台会同中国电子科技网络信息安全有限公司共同采取合理的措施保护用户的个人隐私信息，除法律或有法律赋予权限的政府部门要求或用户同意等原因外，中国家医平台未经用户同意不向除合作单位以外的第三方公开、透露用户个人隐私信息。但是，用户在注册时选择同意，或用户与中国家医平台及合作单位之间就用户个人隐私信息公开或使用另有约定的除外，同时用户应自行承担因此可能产生的任何风险，中国家医平台对此不予负责。同时，为了运营和改善中国家医平台的技术和服务，中国家医平台将可能会自行收集使用非个人隐私信息，这将有助于中国家医平台向用户提供更好的用户体验和提高中国家医平台的服务质量。"])
        contentArray.append(["1、用户违反本《协议》或相关的服务条款的规定，导致或产生的任何第三方主张的任何索赔、要求或损失，包括合理的律师费及其他正当费用，用户同意赔偿中国家医平台并使之免受损害。", "2、用户因第三方如电信部门的通讯线路故障、技术问题、网络、电脑故障、系统不稳定性及其他各种不可抗力原因而遭受的一切损失，中国家医平台及合作单位不承担责任。", "3、因技术故障等不可抗力事件影响到服务的正常运行的，中国家医平台及合作单位承诺在第一时间内与相关单位配合，及时处理进行修复，但用户因此而遭受的一切损失，中国家医平台及合作单位不承担责任。", "4、本服务同大多数互联网服务一样，受包括但不限于用户原因、网络服务质量、社会环境等因素的差异影响，可能受到各种安全问题的侵扰，如他人利用用户的资料，造成现实生活中的骚扰；用户下载安装的其它软件或访问的其他网站中含有“特洛伊木马”等病毒，威胁到用户的计算机信息和数据的安全，继而影响本服务的正常使用等等。用户应加强信息安全及使用者资料的保护意识，要注意加强密码保护，以免遭致损失和骚扰。", "5、用户须明白，使用本服务因涉及Internet服务，可能会受到各个环节不稳定因素的影响。因此，本服务存在因不可抗力、计算机病毒或黑客攻击、系统不稳定、用户所在位置、用户关机以及其他任何技术、互联网络、通信线路原因等造成的服务中断或不能满足用户要求的风险。用户须承担以上风险，中国家医平台不作担保。对因此导致用户不能发送和接受阅读信息、或接发错信息，中国家医平台不承担任何责任。", "6、用户须明白，在使用本服务过程中存在有来自任何他人的包括威胁性的、诽谤性的、令人反感的或非法的内容或行为或对他人权利的侵犯（包括知识产权）的匿名或冒名的信息的风险，用户须承担以上风险，中国家医平台和合作公司对本服务不作任何类型的担保，不论是明确的或隐含的，包括所有有关信息真实性、适商性、适于某一特定用途、所有权和非侵权性的默示担保和条件，对因此导致任何因用户不正当或非法使用服务产生的直接、间接、偶然、特殊及后续的损害，不承担任何责任。", "7、在任何情况下，中国家医平台均不对任何间接性、后果性、惩罚性、偶然性、特殊性或刑罚性的损害，包括因用户使用中国家医平台服务而遭受的损失，承担责任。尽管本协议中可能含有相悖的规定，中国家医平台对您承担的全部责任，无论因何原因或何种行为方式，始终不超过您在使用期间而支付给中国家医平台的费用(如有)。"])
        contentArray.append(["1、中国家医平台郑重提醒用户注意本《协议》中免除中国家医平台责任和加重用户义务的条款，请用户仔细阅读，自主考虑风险。未成年人应在法定监护人的陪同下阅读本《协议》。" , "2、本《协议》所定的任何条款的部分或全部无效者，不影响其它条款的效力。", "3、本《协议》的解释、效力及纠纷的解决，适用于中华人民共和国法律。若用户和中国家医平台之间发生任何纠纷或争议，首先应友好协商解决，协商不成的，用户在此完全同意将纠纷或争议提交北京市海淀区人民法院管辖。", "4、本《协议》的版权由中国家医平台所有，中国家医平台保留一切解释和修改权利。" ])
        
        for (index, str) in subTitleArray.enumerated() {
            var tempContentArray = contentArray[index]
            tempContentArray.insert(str, at: 0)
            let array = setupLabelArray(prefiexLabel: prefiexLabel, titleArray: tempContentArray)
            prefiexLabel = array.last
            if index == subTitleArray.count - 1 {
                let firstLabel:UILabel! = array[1]
                firstLabel?.textColor = UIColor.defaultBlockColor
                firstLabel?.attributedText = NSMutableAttributedString.attributedSubColor("1、中国家医平台郑重提醒用户注意本《协议》中免除中国家医平台责任和加重用户义务的条款，请用户仔细阅读，自主考虑风险。未成年人应在法定监护人的陪同下阅读本《协议》。", "以上各项条款内容的最终解释权及修改权归中国家医平台所有。", UIColor.defaultGrayColor, UIFont.regular(14))
                
                let bottomLabel = UILabel.init(fontSize: 16, colorHex: UIColor.defaultGraykHex, text: "中国家医平台")
                scrollView.addSubview(bottomLabel)
                bottomLabel.snp.makeConstraints { (make) in
                    make.top.equalTo(prefiexLabel.snp.bottom).offset(32)
                    make.centerX.equalToSuperview()
                    make.bottom.equalTo(-(32 + SizeHelper.navigationBarHeight))
                }
            }
        }
        
        
    }
    
}

extension UserProtocolViewController {
    
    func firstContentArray() -> Array<String> {
        var array = ["1、用户充分了解并同意，中国家医平台仅为用户提供家庭医生签约服务相关的信息分享、传送及获取的平台，用户必须为自己注册帐号下的一切行为负责，包括您所传送的任何内容以及由此产生的任何结果。用户应对中国家医平台的内容自行加以判断，并承担因使用内容而引起的所有风险，包括因对内容的正确性、完整性或实用性的依赖而产生的风险。中国家医平台无法且不会对因用户行为而导致的任何损失或损害承担责任。", "2、用户在中国家医平台服务中或通过中国家医平台服务所传送的任何内容并不反映中国家医平台的观点或政策，中国家医平台对此不承担任何责任。", "3、用户充分了解并同意，中国家医平台是一个基于用户签约关系服务联系平台，采用实名制注册。用户须对在中国家医平台上的注册信息的真实性、合法性、有效性承担全部责任，用户不得冒充他人；不得利用他人的名义传播任何信息；不得恶意使用注册帐号导致其他用户误认；否则中国家医平台有权立即停止提供服务，注销注册账号并由用户独自承担由此而产生的一切法律责任。", "4、用户须对在中国家医平台上所传送信息的真实性、合法性、无害性、有效性等全权负责，与用户所传播的信息相关的任何法律责任由用户自行承担。"]
        array.append("5、用户不得利用中国家医平台制作、上载、复制、发送如下内容：" + addLineFeed(array: ["(1)反对宪法所确定的基本原则的；", "(2)危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；", "(3)损害国家荣誉和利益的；", "(4)煽动民族仇恨、民族歧视，破坏民族团结的；", "(5)破坏国家宗教政策，宣扬邪教和封建迷信的；" , "(6)散布谣言，扰乱社会秩序，破坏社会稳定的；", "(7)散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪的；", "(8)侮辱或者诽谤他人，侵害他人合法权益的；", "(9)含有法律法规禁止的其他内容的信息。",]))
        array = array + ["6、中国家医平台可依其合理判断，对违反有关法律法规或本协议约定；或侵犯、妨害、威胁任何人权利或安全的内容，或者假冒他人的行为，中国家医平台有权依法停止传输任何前述内容，并有权依其自行判断对违反本条款的任何人士采取适当的法律行动，包括但不限于，从中国家医平台服务中删除具有违法性、侵权性、不当性等内容，终止违反者的成员资格，阻止其使用中国家医平台全部或部分服务，并且依据法律法规保存有关信息并向有关部门报告等。"]
        array.append("7、用户权利及义务：" + addLineFeed(array: ["(1)中国家医平台账号采用实名制注册，所有权归用户所有，用户有责任保管好自己的账号，禁止赠与、借用、租用、转让或售卖，否则中国家医平台有权利关闭用户的账号。", "(2)用户有权更改、删除在中国家医平台上的个人资料、注册信息及传送内容等，但需注意，为确保签约履约服务的完整性，中国家医平台有权记录上述行为并保留备份数据，以备国家等权威机构的核查评估。", "(3)用户有责任妥善保管注册帐号信息及帐号密码并对注册帐号及密码下的行为承担法律责任。用户同意在任何情况下不使用其他成员的帐号或密码。在用户怀疑自己的帐号或密码可能被他人使用时，应立即通知中国家医平台。", "(4)用户应遵守本协议的各项条款，正确、适当地使用本服务，如因用户违反本协议中的任何条款，中国家医平台有权依据协议终止对违约用户提供的服务。"]))
        return array
    }
    
    func addLineFeed(array:Array<String>) -> String {
        var resultStr:String = "\n"
        for (_, str) in array.enumerated() {
            resultStr = resultStr + str + "\n"
        }
        return resultStr
    }
    
    func getLabel(value:String) -> UILabel {
        let tempLabel = UILabel.init(fontSize: 14, colorHex: UIColor.defaultGraykHex, text: value)
        tempLabel.numberOfLines = 0
        tempLabel.attributedText = NSMutableAttributedString.setupLineMargin(text: value, margin: 4)
        scrollView.addSubview(tempLabel)
        return tempLabel
    }
    func setupLabelArray(prefiexLabel:UILabel?, titleArray:Array<String>) -> Array<UILabel>{
        var prefiexLabel:UILabel = prefiexLabel ?? UILabel.init()
        var array = Array<UILabel>()
        for (index, value) in titleArray.enumerated() {
            let titleLabel = getLabel(value: value)
            if index == 0 {
                titleLabel.textColor = UIColor.defaultBlockColor
            }
            titleLabel.snp.makeConstraints { (make) in
                make.left.width.equalTo(prefiexLabel)
                make.top.equalTo(prefiexLabel.snp.bottom).offset(16)
            }
            prefiexLabel = titleLabel
            array.append(titleLabel)
        }
        return array
        
    }
}

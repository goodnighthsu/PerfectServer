//
//  UserModel.swift
//  CRM
//
//  Created by 徐非 on 16/12/1.
//  Copyright © 2016年 翼点网络. All rights reserved.
//

import Foundation
import PerfectLib
import PerfectHTTP
import JWT

//用户模型
class UserModel:JSONConvertibleObject, NSCoding{
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.sID, forKey: "sID")
        
        aCoder.encode(self.account, forKey: "account")
        aCoder.encode(self.trueName, forKey: "trueName")
        aCoder.encode(self.nickname, forKey: "nickname")
        
        aCoder.encode(self.companyID, forKey: "companyID")
        aCoder.encode(self.teamID, forKey: "teamID")
        
        aCoder.encode(self.gender, forKey: "gender")
        aCoder.encode(self.mobile, forKey: "mobile")
        aCoder.encode(self.eMail, forKey: "eMail")
    }
    
    required init?(coder aDecoder: NSCoder) {
        sID = aDecoder.decodeObject(forKey: "sID") as? String
        
        account = aDecoder.decodeObject(forKey: "account") as? String
        trueName = aDecoder.decodeObject(forKey: "trueName") as? String
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        
        companyID = aDecoder.decodeObject(forKey: "companyID") as? String
        teamID = aDecoder.decodeObject(forKey: "teamID") as? String
        
        gender = aDecoder.decodeObject(forKey: "gender") as? Int
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        eMail = aDecoder.decodeObject(forKey: "eMail") as? String
    }
    
    override init(){
        super.init()
    }
    
    var sID: String?                    //user_id: Int
    var companyID: String?              //company_id: Int
    var teamID: String?                 //team_id: Int
    var adminID: String?                //admin_id: Int
    var account: String?                //account
    var nickname: String?               //user_nick
    var trueName: String?               //true_name
    var portraitURLString: String?      //
    //    var portraitImage: UIImage?         //
    var gender: Int?                    //sex
    var birthday: Date?
    var age: Int?
    var mobile: String?                 //mobile
    var address: AddressModel?
    
    var password: String?               //密码
    var password1: String?
    
    //MARK: 第三方ID
    var thirdType: String?
    var thirdPartyID: String?           //第三方登录ID
    var openID: String?                 //open_id: String
    var wechatID: String?               //wechat_number: String
    var qqID: String?                   //qq_number: INT
    var eMail: String?                  //e_mail
    
    var job: String?
    var income: NSNumber?              //收入
    
    var cardID: String?                          //card_id
    var passportID: String?                      //passport_id
    var passportCountry: String?                 //
    var validity: Date?                         //card_validity: String
    
    var families: [UserModel]?          //亲属
    var relation: String?               //亲属关系
    
    var isSign: Bool?                           //is_sign Int
    var isExperience: Bool?                      //is_experience: Int
    var flightDate: Date?                       //flight_date: String
    var flightNum: String?                      //flight_number: String
    var addTime: Date?                          //add_time: Int 添加日期
    var addIP: String?                          //add_ip: String
    var addAdmin: String?                       //add_admin
    var status: Bool?                            //status Int
    
    //MARK: CurrentUser
    class var currentUser: UserModel? {
        get{
            let userData: Data? = UserDefaults.standard.object(forKey: "CurrentUser") as? Data
            guard let data = userData else{
                return nil
            }
            
            let user: UserModel? = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserModel
            return user
        }
    }
    
    func save() -> Bool{
        let userData: Data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(userData, forKey: "CurrentUser")
        return true
    }
    
    //    //MARK: 返回名字trueName的拼音
    //    func getPinyin() -> String? {
    //        guard let name = self.trueName else {
    //            return nil
    //        }
    //        let format = HanyuPinyinOutputFormat()
    //        let pinyin = PinyinHelper.toHanyuPinyinString(with: name, with: format, with: " ")
    //        return pinyin
    //    }
    
    /*
    //MARK: - 验证
    class func confirmAccount(_ inputString: String?) -> Bool {
        guard let account = inputString else {
            return false
        }
        
        //非符号开头的6-18位字符
        let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9._]{6,18}$", options: .caseInsensitive)
        
        guard  let reg = regex else {
            return false
        }
        
        let matches = reg.matches(in: account, options: .reportCompletion, range: NSMakeRange(0, account.characters.count))
        if matches.count == 0{
            return false
        }
        return true
    }
    
    class func confirmPassword(_ password: String?) -> Bool {
        guard let pwd = password else {
            return false
        }
        
        //非符号开头的6-18位字符
        let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9]{6,18}$", options: .caseInsensitive)
        
        guard  let reg = regex else {
            return false
        }
        
        let matches = reg.matches(in: pwd, options: .reportCompletion, range: NSMakeRange(0, pwd.characters.count))
        if matches.count == 0{
            return false
        }
        return true
    }
    
    class func confirmMobile(_ mobile: String) -> Bool{
        if mobile.characters.count == 0{
            return false
        }
        let regex = try? NSRegularExpression(pattern: "[0-9]", options: .caseInsensitive)
        guard let _ = regex else{
            return false
        }
        
        let matches = regex!.matches(in: mobile, options: .reportCompletion, range: NSMakeRange(0, mobile.characters.count))
        if matches.count == 0{
            return false
        }
        
        return true
    }
    
    
    
    class func confirmEmail(_ email: String) -> Bool{
        if email.characters.count == 0{
            return false
        }
        let regex = try? NSRegularExpression(pattern: "\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*", options: .caseInsensitive)
        guard let _ = regex else{
            return false
        }
        
        let matches = regex!.matches(in: email, options: .reportCompletion, range: NSMakeRange(0, email.characters.count))
        if matches.count == 0{
            return false
        }
        
        return true
    }
 
 */
    
    //MARK: - Parse
    class func parseJSON(_ json: NSDictionary?) -> Any?{
        guard let dic = json else{
            return nil
        }
        
        let model = UserModel()
        model.sID = (dic["user_id"] as? NSNumber)?.stringValue
        model.account = dic["account"] as? String
        model.nickname = dic["user_nick"] as? String
        model.companyID = (dic["company_id"] as? NSNumber)?.stringValue
        model.companyID = (dic["team_id"] as? NSNumber)?.stringValue
        
        model.portraitURLString = dic["head_img"] as? String
        model.trueName = dic["true_name"] as? String
        model.gender = (dic["sex"] as? NSNumber)?.intValue
        
        //
        let birthdayDate = (dic["birth_date"] as? NSNumber)?.doubleValue
        if birthdayDate != nil{
            model.birthday =  Date(timeIntervalSince1970: birthdayDate!)
        }
        
        model.mobile = dic["mobile"] as? String
        model.eMail = dic["e_mail"] as? String
        
        //AddressModel
        let address = AddressModel()
        address.province = dic["province"] as? String
        address.city = dic["city"] as? String
        address.area = dic["area"] as? String
        address.address = dic["address"] as? String
        model.address = address
        
        //
        model.wechatID = dic["wechat_number"] as? String
        model.qqID = dic["qq_number"] as? String
        
        //
        model.job = dic["job"] as? String
        model.income = dic["income"] as? NSNumber
        
        //亲属
        if let familyName = dic["family_name"] as? String{
            let user = UserModel()
            user.trueName = familyName
            if let relation = dic["family_relationship"] as? String{
                user.relation = relation
            }
            if let fMobile = dic["family_mobile"] as? String{
                user.mobile = fMobile
            }
            model.families = [UserModel]()
            model.families?.append(user)
        }
        
        //
        model.cardID = dic["card_id"] as? String
        model.passportID = dic["passport_id"] as? String
        model.passportCountry = dic["passport_country"] as? String
        return model
    }
    
    
    class func parseCustomerDetailJSON(_ json: NSDictionary?) -> Any?{
        guard let dic = json else{
            return nil
        }
        
        let model = UserModel()
        model.sID = (dic["customer_id"] as? NSNumber)?.stringValue
        model.nickname = dic["customer_nick"] as? String
        
        model.companyID = (dic["company_id"] as? NSNumber)?.stringValue
        model.portraitURLString = dic["head_img"] as? String
        model.trueName = dic["true_name"] as? String
        model.gender = (dic["sex"] as? NSNumber)?.intValue
        
        //
        let birthdayDate = (dic["birth_date"] as? NSNumber)?.doubleValue
        if birthdayDate != nil{
            model.birthday =  Date(timeIntervalSince1970: birthdayDate!)
        }
        
        model.mobile = dic["mobile"] as? String
        model.eMail = dic["e_mail"] as? String
        
        //AddressModel
        let address = AddressModel()
        address.province = dic["province"] as? String
        address.city = dic["city"] as? String
        address.district = dic["area"] as? String
        address.address = dic["address"] as? String
        model.address = address
        
        //
        model.wechatID = dic["wechat_number"] as? String
        model.qqID = dic["qq_number"] as? String
        
        //
        model.job = dic["job"] as? String
        model.income = dic["income"] as? NSNumber
        
        //亲属
        if let familyName = dic["family_name"] as? String{
            let user = UserModel()
            user.trueName = familyName
            if let relation = dic["family_relationship"] as? String{
                user.relation = relation
            }
            if let fMobile = dic["family_mobile"] as? String{
                user.mobile = fMobile
            }
            model.families = [UserModel]()
            model.families?.append(user)
        }
        
        //
        model.cardID = dic["card_id"] as? String
        model.passportID = dic["passport_id"] as? String
        model.passportCountry = dic["passport_country"] as? String
        return model
    }
    
    class func parseCustomerListJSON(_ json: NSDictionary?) -> Any?{
        guard let dic = json else{
            return nil
        }
        
        let model = UserModel()
        model.sID = (dic["customer_id"] as? NSNumber)?.stringValue
        model.companyID = (dic["company_id"] as? NSNumber)?.stringValue
        model.trueName = dic["true_name"] as? String
        model.portraitURLString = dic["head_img"] as? String
        return model
    }
    
    
    //MARK: - API
    override func getJSONValues() -> [String : Any] {
        var modelDic = [String: Any]()
        if let sID = self.sID {
            modelDic["id"] = sID
        }
        
        if let trueName = self.trueName {
            modelDic["trueName"] = trueName
        }
        
        if let mobile = self.mobile {
            modelDic["mobile"] = mobile
        }
        
        return modelDic
    }
    
    
    //MARK: 用户详情
    static let detail: RequestHandler = { req, res in
        let userID: String? = req.urlVariables["id"]
        guard let id = userID else{
            res.outputError("\(req.path) need 'id'")
            res.completed()
            return
        }
        let user = UserModel()
        user.sID = id
        res.output(user)
        
        res.completed()
    }
    
    //MARK: 用户列表
    static let list: RequestHandler = { req, res in
        res.validate()
        
        let user1 = UserModel()
        user1.sID = "1"
        user1.trueName = "leon"
        user1.mobile = "13917051234"
        
        let user2 = UserModel()
        user2.sID = "2"
        user2.trueName = "shine"
        
        res.output([user1, user2])
        res.completed()
    }
    
    //MARK: Login
    static let login: RequestHandler = { req, res in
        guard let account = req.param(name: "account") else{
            res.outputError("account can not be null")
            return
        }
        guard let password = req.param(name: "password") else{
            res.outputError("password can not be null")
            return
        }
        
//        if !UserModel.confirmAccount(account) || !UserModel.confirmPassword(password){
//            res.outputError("account or password error")
//        }
        
        //登入成功授权
        let user1 = UserModel()
        user1.sID = "1"
        user1.trueName = "leon"
        user1.mobile = "13917051234"
        
        var claims = ClaimSet()
        claims.issuer = user1.sID
        claims.issuedAt = Date()
        
        let tokenValue = JWT.encode(claims: claims, algorithm: .hs256(JWTSecret.data(using: .utf8)!))
        var cookie = HTTPCookie(name: "token",  value: tokenValue, domain: nil, expires: nil, path: nil, secure: nil, httpOnly: nil, sameSite: nil)
        res.addCookie(cookie)
        
        res.output("success")
    }
}

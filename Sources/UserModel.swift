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
import StORM
import MySQLStORM

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
    
    required override init(){
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
    
    
    //MARK: - JSONConvertable
    static let registerName = "UserModel"
    override public func setJSONValues(_ values: [String: Any]){
        self.sID = (values["user_id"] as? NSNumber)?.stringValue
        self.account = values["account"] as? String
//        self.trueName = values["trueName"] as? String
        self.mobile = values["mobile"] as? String
        self.eMail = values["e_mail"] as? String
    }
    
    override public func getJSONValues() -> [String : Any] {
        var dic = [String: Any]()
        if let _sID = sID{
            dic["id"] = _sID
        }
        if let _account = account{
            dic["account"] = _account
        }
        if let _mobile = mobile{
            dic["mobile"] = _mobile
        }
        if let _eMail = eMail{
            dic["eMail"] = _eMail
        }
        
        return dic
    }
    
    //MARK: - Parse JSON
    class func parseDic(_ dic: Dictionary<String, Any>?) -> UserModel?{
        guard let values = dic else{
            return nil
        }
        let model = UserModel()
        model.sID = (values["user_id"] as? NSNumber)?.stringValue
        model.account  = values["account"] as? String
        model.mobile  = values["mobile"] as? String
        model.eMail  = values["e_mail"] as? String
        
        return model
    }
    
    //MARK: - Request
    //MARK: 用户详情
    static let detail: RequestHandler = { req, res in
        var userID: NSNumber?

        guard let idString = req.urlVariables["id"] else{
            res.outputError("\(req.path) need 'id'")
            res.completed()
            return
        }
        let user = UserModel()
        user.sID = idString
        res.output(user)
        
        res.completed()
    }
    
    //MARK: 用户列表
    static let list: RequestHandler = { req, res in
        res.validate()
        
        var page: String = req.param(name: "page", defaultValue: "0")!
        let pageSize:String = req.param(name: "pagesize", defaultValue: "30")!
        page = "\(page.intValue * pageSize.intValue)"
        
        let stORM = MySQLStORM()
        do {
            let results = try stORM.sqlRows("SELECT * FROM jrk_user ORDER BY user_id DESC limit ?,?", params: [page, pageSize])
            let models: [UserModel?] = results.map{
//                $0.data["_jsonobjid"] = UserModel.registerName
                let user = UserModel.parseDic($0.data)
                return user
            }
            let totalResults = try stORM.sqlRows("SELECT COUNT(user_id) FROM jrk_user", params: [])
            let total = totalResults[0].data["COUNT(user_id)"] as? NSNumber ?? 0
            res.output(["total": total.intValue, "datas":models])
        }catch{
            res.outputError("\(error)")
        }
        
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
    
    //MARK: Regist
    static let regist: RequestHandler = { req, res in
        guard let account = req.param(name: "account") else{
            res.outputError("account can not be null")
            return
        }
        
        guard let password = req.param(name: "password") else{
            res.outputError("password can not be null")
            return
        }
        
        let user = UserModel()
        user.account = account
        user.password = password
    }
}

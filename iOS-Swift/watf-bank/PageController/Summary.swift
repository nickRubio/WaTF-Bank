import UIKit

class Summary : UIViewController {
    
    @IBOutlet weak var username : UILabel!
    @IBOutlet weak var tel : UILabel!
    @IBOutlet weak var balance : UILabel!
    @IBOutlet weak var accountNo : UILabel!
    @IBOutlet weak var accLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.accLabel.text = "Account Summary"
        self.accLabel.textColor = UIColor.black

        guard let token = KeyChain.load("token"),
              let acc = KeyChain.load("accountNo") else {
                    Util.alert(self, "Invalid Token")
                    return
            }
        
        let input = ["accountNo":acc,"token":token]
        Http().post(input, "accountSummary", completionHandler: {(re: [String:Any]) in
            var res = re as! [String:String]
            if let e = res["error"] {
                Util.alert(self, e)
            }
            else if res["message"] == "Success" {
                self.username.text = "Username: " + res["username"]!
                self.tel.text = "Telephone: " + res["tel"]!
                self.balance.text = "Balance: " + res["balance"]!
                self.accountNo.text = "Account No: " + acc
                
                self.username.textColor = UIColor.black
                self.tel.textColor = UIColor.black
                self.balance.textColor = UIColor.black
                self.accountNo.textColor = UIColor.black
            }
            else if let m = res["message"] {
                Util.alert(self, m)
            }
            else {
                Util.alert(self, "An Error Occurred")
            }
        })
    }
}

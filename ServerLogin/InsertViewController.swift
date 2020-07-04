//
//  InsertViewController.swift
//  ServerLogin
//
//  Created by SWUCOMPUTER on 2020/07/02.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var PutTodo: UITextField!
    @IBOutlet var ButtonSave: UIBarButtonItem!
    @IBOutlet var PutDetail: UITextView!
    @IBOutlet var DatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // delegate 연결
    textField.resignFirstResponder() //textDescription.becomeFirstResponder()
        return true
    }
    // return à Done 변경

    @IBAction func ButtonSave(_ sender: UIBarButtonItem) {
        let name = PutTodo.text!
        let description = PutDetail.text!
        if (name == "" || description == "") {
        let alert = UIAlertController(title: "제목/설명을 입력하세요",
        message: "Save Failed!!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
            return
        }
        let myUrl = URL(string: "http://condi.swu.ac.kr/student/T01/newlogin/insertUpload.php");
        var request = URLRequest(url:myUrl!);
        request.httpMethod = "POST";
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type")
        var body = Data()
        var dataString = "--\(boundary)\r\n"
        dataString += "Content-Disposition: form-data;"
        dataString += "Content-Type: application/octet-stream\r\n\r\n"
        if let data = dataString.data(using: .utf8) { body.append(data) }
        
        dataString = "\r\n"
        dataString += "--\(boundary)--\r\n"
        if let data = dataString.data(using: .utf8) { body.append(data) }
        
        request.httpBody = body
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { print("Error: calling POST"); return; }
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return;
            }
            if String(data: receivedData, encoding: .utf8) != nil{
            semaphore.signal()
            }
        }
        task.resume()
        let urlString: String = "http://condi.swu.ac.kr/student/T01/login/insertUpload.php"
        guard let requestURL = URL(string: urlString) else { return }
        request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let userID = appDelegate.ID else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myDate = formatter.string(from: Date())
        var restString: String = "id=" + userID + "&name=" + name
        restString += "&description=" + description
        restString += "&date=" + myDate
        request.httpBody = restString.data(using: .utf8)
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request) { (responseData, response, responseError) in
        guard responseError == nil else { return }
        guard let receivedData = responseData else { return }
        if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
        }
        task2.resume()
        _ = self.navigationController?.popViewController(animated: true)
        }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func getDateTime(_ sender: Any) {
          let dateFormatter = DateFormatter()
          
          // .none, .short, .medium, .long, .full
          dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        
    }
}

//
//  DetailViewController.swift
//  ServerLogin
//
//  Created by SWUCOMPUTER on 2020/07/03.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var LookTodo: UILabel!
    @IBOutlet var LookDetail: UILabel!
    @IBOutlet var DateLabel: UILabel!
    
    var selectedData: TodoData?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DeleteButton(_ sender: UIButton) {
    let alert=UIAlertController(title:"정말 삭제 하시겠습니까?", message: "",preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .cancel, handler: { action in
    let urlString: String = "http://condi.swu.ac.kr/student/T01/newlogin/deleteTodo.php"
            guard let requestURL = URL(string: urlString) else { return }
    var request = URLRequest(url: requestURL)
    request.httpMethod = "POST"
     
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (responseData, response, responseError) in guard responseError == nil else { return }
    guard let receivedData = responseData else { return }
    if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
    }
    task.resume()
            self.navigationController?.popViewController(animated: true)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    }
    
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

}
*/

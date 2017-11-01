//
//  TestingVC.swift
//  image_recognition_ios
//
//  Created by Farhan Rahman on 10/31/17.
//  Copyright © 2017 Farhan Rahman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TestingVC: UIViewController {
    
    @IBOutlet weak var test_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var TEST_API = "http://localhost:3000/api/testing";
        
         let imageData:NSData = UIImageJPEGRepresentation(test_image.image!, 1) as! NSData
        
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)

        // All three of these calls are equivalent
        Alamofire.request(TEST_API, method: .post, parameters: ["binary_image" : strBase64]).responseJSON { response in

            if let data = response.data {
                
                var json_data = JSON(data)
                
                var tf_data = json_data["data"]
                
                
                var first_type = tf_data[0]
                var second_type = tf_data[1]
                var third_type = tf_data[2]

                var first_percentage = first_type["percentage"].string
                var first_name = first_type["name"].string
                
                var second_percentage = second_type["percentage"].string;
                var second_name = second_type["name"].string;
                
                var third_percentage = third_type["percentage"].string
                var third_name = third_type["name"].string
                
                
                print(third_name)

                
            }
        }

        
//        let url = URL(string: TEST_API)!
//        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        let postString = "binary_image=asdf";
//        request.httpBody = postString.data(using: .utf8)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                print("error=\(error)")
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//            }
//            f
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
//        }
//        task.resume()
//
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

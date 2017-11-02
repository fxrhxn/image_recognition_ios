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
import SwiftSpinner




class TestingVC: UIViewController {
    
    @IBOutlet weak var test_image: UIImageView!
    
    var progress = 0.0
    
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        self.testSpinner();

    }
  
    
    //Function to test the spinner.
    func testSpinner(){
        
        self.showSpinner();
        
        //Mimic the response.
        delay(seconds: 5.0) {
            self.spinnerError()
        }
        
        //Hide the spinner 2 seconds later.
        delay(seconds : 7.0){
            self.hideSpinner()
        }
    }
    
    //Function to show the spinner.
    func showSpinner(){
        SwiftSpinner.show(delay: 0.0, title: "Classifying image...", animated: true)
        SwiftSpinner.sharedInstance.innerColor = UIColor.green.withAlphaComponent(0.5)
        
    }
    
    //Function that hides the spinner.
    func hideSpinner(){
        SwiftSpinner.hide()
    }
    
    //Error for the spinner.
    func spinnerError(){
        SwiftSpinner.sharedInstance.innerColor = UIColor.red.withAlphaComponent(0.5)
        SwiftSpinner.show(delay: 0.0, title: "Error - Smh :(", animated: false)
    }
    
    //Success for the spinner.
    func spinnerSuccess(){
        SwiftSpinner.sharedInstance.innerColor = UIColor.green.withAlphaComponent(0.5)
        SwiftSpinner.show(delay: 1.0, title: "Image Classified", animated: false)
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

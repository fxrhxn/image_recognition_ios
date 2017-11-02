//
//  TensorflowVC.swift
//  image_recognition_ios
//
//  Created by Farhan Rahman on 10/26/17.
//  Copyright © 2017 Farhan Rahman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class TensorflowVC: UIViewController {
    
    var takenPhoto: UIImage?
    
    //Image view that is shown.
    @IBOutlet weak var imageView: UIImageView!
    
    //Guesses that are made by tensorflow shown in the UI label.
    @IBOutlet weak var firstGuess: UILabel!
    @IBOutlet weak var secondGuess: UILabel!
    @IBOutlet weak var thirdGuess: UILabel!

    
    
    //The delay function to hold shit out.
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
            // Set the image to the image view.
        if let availableImage = takenPhoto {
            
            //Show the spinner.
            self.showSpinner();
            
           
         imageView.image = availableImage
            
            let imageData:NSData = UIImageJPEGRepresentation(availableImage, 1) as! NSData

            
            //Call an API to custom tensorflow API and have that update the labels.
            var API_ROUTE = "https://tensorflow-image.herokuapp.com/api/testing"

            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            
            
            // All three of these calls are equivalent
            Alamofire.request(API_ROUTE, method: .post, parameters: ["binary_image" : strBase64]).responseJSON { response in
                
              //  let json = try? JSONSerialization.jsonObject(with: response, options: [])
                
                // responseString worked kinda
                
             
                if let data = response.result.value {
                    
                    //Show a spinner that shows success.
                    self.spinnerSuccess()
                    
                    //Remove the spinner with a delay
                    self.delay(seconds: 1.6, completion: {
                    
                        self.hideSpinner()
                    })
                    
    
                    var tf_data = JSON(data)
                    
                  
                    var first_type = tf_data[0]
                    var second_type = tf_data[1]
                    var third_type = tf_data[2]
                    
                   
                    
                    var first_percentage = first_type["percentage"]
                    var first_name = first_type["name"]

                    var second_percentage = second_type["percentage"];
                    var second_name = second_type["name"];

                    var third_percentage = third_type["percentage"]
                    var third_name = third_type["name"]

                  
                  
                    
                    self.clearLabels()

                    self.firstGuess.text = "\(first_name)  \(first_percentage)%"
                    
                    self.secondGuess.text = "\(second_name)  \(second_percentage)%"
                    
                   self.thirdGuess.text = "\(third_name)  \(third_percentage)%"
                   
                    
              
                    
                }
            }
            
            
        }
 
        
    }
    
    
    //Function to show an activity indicator.
    func showActivityIndicatory(uiView: UIView) {
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        //actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        if #available(iOS 11.0, *) {
            actInd.color = UIColor(named: "purple")
        } else {
            // Fallback on earlier versions
        };
        
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        uiView.addSubview(actInd)
        actInd.startAnimating()
    }
    
    //Function that clears all of the labels.
    func clearLabels(){
        self.firstGuess.text = ""
        self.secondGuess.text = ""
        self.thirdGuess.text = ""
    }
    
    func showLabels(first : String?, second : String?, third : String?){
        
        if(first! != nil){
            self.firstGuess.text = first
        }
        
        if(second! != nil){
            self.secondGuess.text = second
        }
        
        if(third! != nil){
            self.thirdGuess.text = third
        }
        
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
        SwiftSpinner.sharedInstance.innerColor = UIColor.white.withAlphaComponent(0.5)
        
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
        SwiftSpinner.sharedInstance.innerColor = UIColor.magenta.withAlphaComponent(0.5)
        SwiftSpinner.show(delay: 2.0, title: "Image Classified", animated: false)
    }
    

    func breakString(str : String) -> String {
        
        let index = str.index(str.startIndex, offsetBy: 10)
        return str.substring(to: index)
        
    }
    
    
    
    //Back button is clicked.
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)

        
    }

}

//
//  TensorflowVC.swift
//  image_recognition_ios
//
//  Created by Farhan Rahman on 10/26/17.
//  Copyright © 2017 Farhan Rahman. All rights reserved.
//

import UIKit
import Alamofire

class TensorflowVC: UIViewController {
    
    var takenPhoto: UIImage?
    
    //Image view that is shown.
    @IBOutlet weak var imageView: UIImageView!
    
    //Guesses that are made by tensorflow shown in the UI label.
    @IBOutlet weak var firstGuess: UILabel!
    @IBOutlet weak var secondGuess: UILabel!
    @IBOutlet weak var thirdGuess: UILabel!
    
    //The spinner view.
    @IBOutlet weak var spinnerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            // Set the image to the image view.
        if let availableImage = takenPhoto {
            
           // print(availableImage)
         imageView.image = availableImage
        }
        
        clearLabels()
        showActivityIndicatory(uiView: spinnerView)
        showLabels(first : "Yeah", second : "Sure", third : "Mhmmmm")
        
        //Call an API to custom tensorflow API and have that update the labels.
        var API_ROUTE = "https://tensorflow-image.herokuapp.com/api/testing";
        
        // All three of these calls are equivalent
        Alamofire.request(API_ROUTE, method: .post, parameters: ["binary_image" : "TESTING HAHAHA"]).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
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
    
    
    //Back button is clicked.
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)

        
    }

}

//
//  MaterialView.swift
//  WishList
//
//  Created by Khoa on 1/31/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import Foundation

import UIKit


private var materialKey = false
extension UIView{
    
    
    
    @IBInspectable var materialDesgin : Bool {
        
        
        get {
            return materialKey
        }
        
        set {
            materialKey = newValue
            
            if materialKey {
                
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowColor = UIColor(colorLiteralRed: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
                
                self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
                
                
            }else {
              
                self.layer.cornerRadius = 0
                self.layer.shadowRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowColor = nil
            }
        }
    }
    
    
}

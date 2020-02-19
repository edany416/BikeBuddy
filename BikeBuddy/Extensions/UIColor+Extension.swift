//
//  UIColor+Extension.swift
//  BikeBuddy
//
//  Created by Edan on 1/23/20.
//  Copyright © 2020 Edan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    
    func colorForSpeedInMetersPerSecond(_ speed: Double) -> UIColor {
        let speedInMPH = speed * 2.237
        if 0 > speedInMPH {
            return UIColor.black
        }
        if 0 <= speedInMPH && speedInMPH <= 1 {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        if 1 < speedInMPH && speedInMPH <= 2 {
            return #colorLiteral(red: 0.9647058824, green: 0.9764705882, blue: 0.9803921569, alpha: 1)
        }
        
        if 2 < speedInMPH && speedInMPH <= 3 {
            return #colorLiteral(red: 0.9294117647, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
        }
        
        if 3 < speedInMPH && speedInMPH <= 4 {
            return #colorLiteral(red: 0.8980392157, green: 0.937254902, blue: 0.9490196078, alpha: 1)
        }
        
        if 4 < speedInMPH && speedInMPH <= 5 {
            return #colorLiteral(red: 0.862745098, green: 0.9137254902, blue: 0.9333333333, alpha: 1)
        }
        
        if 5 < speedInMPH && speedInMPH <= 6 {
            return #colorLiteral(red: 0.831372549, green: 0.8941176471, blue: 0.9137254902, alpha: 1)
        }
        
        if 6 < speedInMPH && speedInMPH <= 7 {
            return #colorLiteral(red: 0.7960784314, green: 0.8745098039, blue: 0.8980392157, alpha: 1)
        }
        
        if 7 < speedInMPH && speedInMPH <= 8 {
            return #colorLiteral(red: 0.7647058824, green: 0.8509803922, blue: 0.8823529412, alpha: 1)
        }
        
        if 8 < speedInMPH && speedInMPH <= 9 {
            return #colorLiteral(red: 0.7294117647, green: 0.831372549, blue: 0.8666666667, alpha: 1)
        }
        
        if 9 < speedInMPH && speedInMPH <= 10 {
            return #colorLiteral(red: 0.6980392157, green: 0.8117647059, blue: 0.8509803922, alpha: 1)
        }
        
        if 10 < speedInMPH && speedInMPH <= 11 {
            return #colorLiteral(red: 0.662745098, green: 0.7882352941, blue: 0.831372549, alpha: 1)
        }
        
        if 11 < speedInMPH && speedInMPH <= 12 {
            return #colorLiteral(red: 0.6274509804, green: 0.768627451, blue: 0.8156862745, alpha: 1)
        }
        
        if 12 < speedInMPH && speedInMPH <= 13 {
            return #colorLiteral(red: 0.5960784314, green: 0.7490196078, blue: 0.8, alpha: 1)
        }
        
        if 13 < speedInMPH && speedInMPH <= 14 {
            return #colorLiteral(red: 0.5607843137, green: 0.7254901961, blue: 0.7843137255, alpha: 1)
        }
        
        if 14 < speedInMPH && speedInMPH <= 15 {
            return #colorLiteral(red: 0.5294117647, green: 0.7058823529, blue: 0.768627451, alpha: 1)
        }
        
        if 15 < speedInMPH && speedInMPH <= 16 {
            return #colorLiteral(red: 0.4941176471, green: 0.6862745098, blue: 0.7490196078, alpha: 1)
        }
        
        if 16 < speedInMPH && speedInMPH <= 17 {
            return #colorLiteral(red: 0.462745098, green: 0.6666666667, blue: 0.7333333333, alpha: 1)
        }
        
        if 17 < speedInMPH && speedInMPH <= 18 {
            return #colorLiteral(red: 0.4274509804, green: 0.6431372549, blue: 0.7176470588, alpha: 1)
        }
        
        if 18 < speedInMPH && speedInMPH <= 19 {
            return #colorLiteral(red: 0.4352941176, green: 0.6235294118, blue: 0.7019607843, alpha: 1)
        }
        
        if 19 < speedInMPH && speedInMPH <= 20 {
            return #colorLiteral(red: 0.3607843137, green: 0.6039215686, blue: 0.6862745098, alpha: 1)
        }
        
        if 20 < speedInMPH && speedInMPH <= 21 {
            return #colorLiteral(red: 0.3254901961, green: 0.5803921569, blue: 0.6666666667, alpha: 1)
        }
        
        if 21 < speedInMPH && speedInMPH <= 22 {
            return #colorLiteral(red: 0.2941176471, green: 0.5607843137, blue: 0.6509803922, alpha: 1)
        }
        
        if 22 < speedInMPH && speedInMPH <= 23 {
            return #colorLiteral(red: 0.2588235294, green: 0.5411764706, blue: 0.6352941176, alpha: 1)
        }
        
        if 23 < speedInMPH && speedInMPH <= 24 {
            return #colorLiteral(red: 0.2274509804, green: 0.5176470588, blue: 0.6196078431, alpha: 1)
        }
        
        if 24 < speedInMPH && speedInMPH <= 25 {
            return #colorLiteral(red: 0.1921568627, green: 0.4588235294, blue: 0.6039215686, alpha: 1)
        }
        
        if 25 < speedInMPH && speedInMPH <= 26 {
            return #colorLiteral(red: 0.1607843137, green: 0.4784313725, blue: 0.5843137255, alpha: 1)
        }
        
        if 26 < speedInMPH && speedInMPH <= 27 {
            return #colorLiteral(red: 0.1254901961, green: 0.4549019608, blue: 0.568627451, alpha: 1)
        }
        
        if 27 < speedInMPH && speedInMPH <= 28 {
            return #colorLiteral(red: 0.09411764706, green: 0.4352941176, blue: 0.5529411765, alpha: 1)
        }
        
        if 28 < speedInMPH && speedInMPH <= 29 {
            return #colorLiteral(red: 0.05882352941, green: 0.4156862745, blue: 0.537254902, alpha: 1)
        }
        
        if 29 < speedInMPH && speedInMPH <= 30 {
            return #colorLiteral(red: 0.02745098039, green: 0.3960784314, blue: 0.5215686275, alpha: 1)
        }
        return UIColor.systemRed
    }
}

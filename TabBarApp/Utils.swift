//
//  Utils.swift
//
//  Created by main on 4/11/16.
//  Copyright © 2016 Gary Hanson. All rights reserved.
//

import UIKit

let scaleFactor = UIScreen.main.bounds.height / 667.0


extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    var stringByDeletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha )
    }
}

func scaled(value: CGFloat) -> CGFloat {
    return  value * scaleFactor
}

struct FileUtilities {
    
    static func documentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
}


func tbmdDateStringToFullDate(date: String) -> String {
    // really just a short ISO 8601 date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let d = dateFormatter.date(from: date)

    guard d != nil else {
        return ""
    }

    //dateFormatter.dateFormat = "MMMM d,yyyy"
    dateFormatter.dateStyle = .long
    let nd = dateFormatter.string(from: d!)

    return nd
}


class Debouncer {

    var currentWorkItem: DispatchWorkItem?

    func debounce(delay: DispatchTimeInterval, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
        return {  [weak self] in
            guard let self = self else { return }
            self.currentWorkItem?.cancel()
            self.currentWorkItem = DispatchWorkItem { action() }
            queue.asyncAfter(deadline: .now() + delay, execute: self.currentWorkItem!)
        }
    }
}


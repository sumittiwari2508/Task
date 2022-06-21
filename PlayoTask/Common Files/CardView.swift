//
//  CardView.swift
//  PlayoTask
//
//  Created by Kripa Tripathi on 21/06/22.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
   // @IBInspectable var cornerRadius: CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.3
    
    override func layoutSubviews() {
       layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
    }
    
}

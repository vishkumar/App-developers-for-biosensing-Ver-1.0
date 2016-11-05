//
//  MainInterface.swift
//  Biosensor App
//
//  Created by bhansali on 10/8/16.
//  Copyright © 2016 Vishal. All rights reserved.
//


import UIKit

open class MainInterface: UIView {
    
//    override open func draw(_ rect: CGRect)
//    {
//        drawRingFittingInsideView(14,width: 5,height: 5,x: 2,y: 3, rad: 2, color: "red", fracOfCircle: 4.0, fontSize: 28 )
//        drawRingFittingInsideView(7,width: 8,height: 8,x: 4,y: 1.4, rad: 4, color: "green", fracOfCircle: 4.0, fontSize: 23)
//        drawRingFittingInsideView(7,width: 8,height: 8,x: 1.35,y: 1.4, rad: 4, color: "blue", fracOfCircle: 4.0, fontSize: 23)
//        
//    }
//    
//    func drawRingFittingInsideView(_ lineWidth: CGFloat,width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, rad: CGFloat, color: String, fracOfCircle: Double, fontSize: CGFloat) -> CAShapeLayer
//    {
//        let halfSize:CGFloat = min( bounds.size.width/width, bounds.size.height/height)
//        let desiredLineWidth:CGFloat = lineWidth    // your desired value
//        
//        let circlePath = UIBezierPath(
//            arcCenter: CGPoint(x:bounds.size.width/x,y:bounds.size.height/y),
//            radius: CGFloat( halfSize - (desiredLineWidth/rad) ),
//            startAngle: CGFloat(M_PI_2) * 3.0,
//            endAngle:CGFloat(M_PI_2) * 3.0 + CGFloat(M_PI) * 2.0,
//            clockwise: true)
//        
//        let shapeLayer = CAShapeLayer()
//        let text = CATextLayer()
//        shapeLayer.path = circlePath.cgPath
//        let fractionOfCircle = fracOfCircle / 4.0
//        shapeLayer.fillColor = UIColor.white.cgColor
//        if(color=="red"){
//            shapeLayer.strokeColor = UIColor.red.cgColor
//        }
//        else if(color=="green"){
//            shapeLayer.strokeColor = UIColor.green.cgColor
//        }
//        else if(color=="blue"){
//            shapeLayer.strokeColor = UIColor.blue.cgColor
//        }
//        
//        shapeLayer.lineWidth = desiredLineWidth
//        shapeLayer.borderColor = UIColor.black.cgColor
//        shapeLayer.borderWidth=20
//        
//        // When it gets to the end of its animation, leave it at 0% stroke filled
//        shapeLayer.strokeEnd = 1.0
//        text.string = "76"
//        // set the string
//        text.fontSize = fontSize
//        text.foregroundColor = UIColor.black.cgColor
//        text.frame = CGRect(x: (bounds.size.width/x)-10, y: (bounds.size.height/y)-13, width: 80, height: 40)
//        
//        // text.foregroundColor = UIColor.blackColor().CGColor
//        self.layer.addSublayer(shapeLayer)
//        self.layer.addSublayer(text)
//        // Configure the animation
//        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        drawAnimation.repeatCount = 1.0
//        
//        // Animate from the full stroke being drawn to none of the stroke being drawn
//        drawAnimation.fromValue = NSNumber(value: 0.0 as Float)
//        drawAnimation.toValue = NSNumber(value: fractionOfCircle as Double)
//        
//        drawAnimation.duration = 2.0
//        
//        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        
//        // Add the animation to the circle
//        shapeLayer.add(drawAnimation, forKey: "drawCircleAnimation")
//        
//        return shapeLayer
//    }
    
}

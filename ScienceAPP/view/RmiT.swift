//
//  RmiT.swift
//  ScienceAPP
//
//  Created by 张睿 on 27/3/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import UIKit

class BezierText: UIView {
   
    private let duration:TimeInterval = 3
    

    private let pathLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
   
        pathLayer.frame = self.bounds
        pathLayer.isGeometryFlipped = true
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.black.cgColor
        self.layer.addSublayer(pathLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func show(text: String) {
   
        let textPath = bezierPathFrom(string: text)
        
    
        pathLayer.bounds = textPath.cgPath.boundingBox
     
        pathLayer.path = textPath.cgPath
        
    
        let textAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        textAnimation.duration = duration
        textAnimation.fromValue = 0
        textAnimation.toValue = 1
        //textAnimation.repeatCount = HUGE
        pathLayer.add(textAnimation, forKey: "strokeEnd")
    }
    
    private func bezierPathFrom(string:String) -> UIBezierPath{
        let paths = CGMutablePath()
        let fontName = __CFStringMakeConstantString("SnellRoundhand")!
        let fontRef:AnyObject = CTFontCreateWithName(fontName, 20, nil)
        
        let attrString = NSAttributedString(string: string, attributes:
            [kCTFontAttributeName as NSAttributedStringKey : fontRef])
        let line = CTLineCreateWithAttributedString(attrString as CFAttributedString)
        let runA = CTLineGetGlyphRuns(line)
        
        for runIndex in 0..<CFArrayGetCount(runA) {
            let run = CFArrayGetValueAtIndex(runA, runIndex);
            let runb = unsafeBitCast(run, to: CTRun.self)
            
            let CTFontName = unsafeBitCast(kCTFontAttributeName,
                                           to: UnsafeRawPointer.self)
            
            let runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb),CTFontName)
            let runFontS = unsafeBitCast(runFontC, to: CTFont.self)
            
            let width = UIScreen.main.bounds.width
            
            var temp = 0
            var offset:CGFloat = 0.0
            
            for i in 0..<CTRunGetGlyphCount(runb) {
                let range = CFRangeMake(i, 1)
                let glyph = UnsafeMutablePointer<CGGlyph>.allocate(capacity: 1)
                glyph.initialize(to: 0)
                let position = UnsafeMutablePointer<CGPoint>.allocate(capacity: 1)
                position.initialize(to: .zero)
                CTRunGetGlyphs(runb, range, glyph)
                CTRunGetPositions(runb, range, position);
                
                let temp3 = CGFloat(position.pointee.x)
                let temp2 = (Int) (temp3 / width)
                let temp1 = 0
                if(temp2 > temp1){
                    
                    temp = temp2
                    offset = position.pointee.x - (CGFloat(temp) * width)
                }
                if let path = CTFontCreatePathForGlyph(runFontS,glyph.pointee,nil) {
                    let x = position.pointee.x - (CGFloat(temp) * width) - offset
                    let y = position.pointee.y - (CGFloat(temp) * 80)
                    let transform = CGAffineTransform(translationX: x, y: y)
                    paths.addPath(path, transform: transform)
                }
                
                glyph.deinitialize()
                glyph.deallocate(capacity: 1)
                position.deinitialize()
                position.deallocate(capacity: 1)
            }
        }
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.append(UIBezierPath(cgPath: paths))
        
        return bezierPath
    }
}

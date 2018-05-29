//
//  waterview.swift
//  ScienceAPP
//
//  Created by 张睿 on 20/3/18.
//  Copyright © 2018 张睿. All rights reserved.
//

import Foundation
import UIKit

class waterview: UIView {
    
    lazy var waveDisplaylink = CADisplayLink()
    
    lazy var firstWaveLayer = CAShapeLayer()
    
    lazy var secondWaveLayer = CAShapeLayer()
    
    var firstWaveColor: UIColor?
    
    var waveA: CGFloat = 10
    
    var waveW: CGFloat = 1/30.0;
    
    var offsetX: CGFloat = 0
    
    var currentK: CGFloat = 0
    
    var waveSpeed: CGFloat = 0
    
    var waterWaveWidth: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // wave width
        waterWaveWidth = bounds.size.width
        // wave color
        firstWaveColor = UIColor.green
        // wave Speed
        waveSpeed = 0.4 / CGFloat(M_PI)
        
        firstWaveLayer.fillColor = UIColor.black.cgColor
        
        //        firstWaveLayer.strokeColor = UIColor.blue.cgColor
        firstWaveLayer.strokeStart = 0.0
        firstWaveLayer.strokeEnd = 0.8
        
        secondWaveLayer.fillColor = UIColor.red.cgColor
        
        //        secondWaveLayer.strokeColor = UIColor.blue.cgColor
        secondWaveLayer.strokeStart = 0.0
        secondWaveLayer.strokeEnd = 0.8
        layer.addSublayer(firstWaveLayer)
        layer.addSublayer(secondWaveLayer)
        
        
        waveSpeed = 0.08
        
        waveA = 8
        
        waveW = 2 * CGFloat(M_PI) / bounds.size.width
        
        currentK = bounds.size.height / 1.35
        
        waveDisplaylink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        waveDisplaylink.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    @objc private func getCurrentWave(disPlayLink: CADisplayLink) {
        
        offsetX += waveSpeed
        setCurrentFirstWaveLayerPath()
    }
    
    private func setCurrentFirstWaveLayerPath() {
        
        let path = CGMutablePath()
        var y = currentK
        path.move(to: CGPoint(x: 0, y: y))
        
        for i in 0...Int(waterWaveWidth) {
            y = waveA * sin(waveW * CGFloat(i) + offsetX) + currentK
            path.addLine(to: CGPoint(x: CGFloat(i), y: y))
        }
        
        path.addLine(to: CGPoint(x: waterWaveWidth, y: bounds.size.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        path.closeSubpath()
        firstWaveLayer.path = path
        
        
        let path2 = CGMutablePath()
        var y2 = currentK
        path2.move(to: CGPoint(x: 0, y: y))
        
        for i in 0...Int(waterWaveWidth) {
            y2 = waveA * sin(waveW * CGFloat(i) + offsetX - waterWaveWidth/2 ) + currentK
            path2.addLine(to: CGPoint(x: CGFloat(i), y: y2))
        }
        
        path2.addLine(to: CGPoint(x: waterWaveWidth, y: bounds.size.height))
        path2.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        path2.closeSubpath()
        secondWaveLayer.path = path2
    }
    
    deinit {
        waveDisplaylink.invalidate()
    }
    
}

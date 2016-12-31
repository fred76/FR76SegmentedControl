//
//  MySegment.swift
//  segmentControl
//
//  Created by Alberto Lunardini on 31/12/16.
//  Copyright © 2016 Alberto Lunardini. All rights reserved.

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

class MySegment: UIControl {
    
    
    fileprivate var imageViews = [UIView]()
    
    fileprivate var  shapeLayerArray = [CAShapeLayer]()
    
    fileprivate var labels = [UILabel]()
    
    public var  colorArray : [UIColor]!
    
    public var imageToAdd: [String]!
    
    var labelText: [String]!
    
    let circleLayer = CAShapeLayer()
    
    var imageArray = [CALayer]()
    
    @IBInspectable var selectedLabelColor : UIColor = UIColor.black {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var unselectedLabelColor : UIColor = UIColor.white {
        didSet {
            setSelectedColors()
        }
    }
    @IBInspectable var font : UIFont! = UIFont.systemFont(ofSize: 12) {
        didSet {
            setFont()
        }
    }
    
    func setSelectedColors(){
        for item in labels {
            item.textColor = unselectedLabelColor
        }
        
        if labels.count > 0 {
            labels[0].textColor = selectedLabelColor
        }
        
        
    }
    
    func setFont(){
        for item in labels {
            item.font = font
        }
    }
    
    @IBInspectable var selectedIndex : Int = 0  
    
    
    @IBInspectable var borderColor : UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var imageTopInset : CGFloat = 0
    
    @IBInspectable var imageSize : CGFloat = 0
    
    @IBInspectable var labelHeight : CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
    }
    
    func setupView(){
        layer.borderColor = UIColor(white: 1.0, alpha: 0).cgColor
        layer.borderWidth = 2
        backgroundColor = UIColor.clear
        setupLabels()
    }
    
    func setupLabels(){
        for label in imageViews {
            label.removeFromSuperview()
        }
        
        imageViews.removeAll(keepingCapacity: true)
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        for index in 0...imageToAdd.count-1 {
            
            let imageView = UIImageView(frame: CGRect(
                x: 0,
                y: 0,
                width: 125,
                height: 80))
            
            
            imageView.backgroundColor = colorArray[index]
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(imageView)
            
            imageViews.append(imageView)
            
            let label = UILabel(frame: CGRect(x: 0, y:0, width: 110, height: 70))
            
            label.text = labelText[index]
            label.backgroundColor = UIColor.clear
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 0
            label.textAlignment = .center
            label.textColor = unselectedLabelColor
            label.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(label)
            
            labels.append(label)
            
        }
        
        addIndividualItemConstraintsForLabels(labels, mainView: self, padding: 5, labelHeight: labelHeight)
        addIndividualItemConstraints(imageViews, mainView: self, padding: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayerArray.removeAll(keepingCapacity: true)
        
        for index in 0...imageToAdd.count-1 {
            
            
            let circleLayer = CAShapeLayer()
            let a = imageViews[index].frame.size
            
            let imageLayer = CALayer()
            
            imageLayer.backgroundColor = UIColor.clear.cgColor
            imageLayer.bounds = CGRect(x: a.width/2, y:a.height/2 , width: imageSize  , height: imageSize )
            imageLayer.position = CGPoint(x: a.width/2, y: imageTopInset)
            imageLayer.contents = UIImage(named:imageToAdd[index])?.cgImage
            
            if index == selectedIndex {
                
                circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y:0, width: self.bounds.width  , height: self.bounds.width )).cgPath
                circleLayer.position = CGPoint(x: a.width/2-self.bounds.width/2, y: imageTopInset-self.bounds.width/2)
                
                
            } else {
                
                circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y:0, width: imageSize  , height: imageSize )).cgPath
                circleLayer.position = CGPoint(x: a.width/2-imageSize/2, y: imageTopInset-imageSize/2)
                
            }
            imageArray.append(imageLayer)
            
            shapeLayerArray.append(circleLayer)
            
            imageViews[index].layer.mask =  shapeLayerArray[index]
            imageViews[index].layer.addSublayer(imageLayer)
            
            
        }
        displayNewSelectedIndex()
        
    }
    
    
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let location = touch.location(in: self)
        
        var calculatedIndex : Int?
        for (index, item) in imageViews.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
                
                
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            addTarget(self, action: #selector(MySegment.displayNewSelectedIndex), for: UIControlEvents.valueChanged)
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    
    
    
    func displayNewSelectedIndex(){
        
        for lab in labels {
            
            
            lab.textColor = unselectedLabelColor
            
        }
        
        for lab in imageViews {
            
            let circleLayer = CAShapeLayer()
            
            
            
            circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y:0, width: imageSize  , height: imageSize )).cgPath
            circleLayer.position = CGPoint(x: lab.frame.width/2-imageSize/2, y: imageTopInset-imageSize/2)
            
            lab.layer.mask = circleLayer
            
            
        }
        
        for (index, a) in imageViews.enumerated() {
            
            
            
            if(selectedIndex == index){
                let label = labels[selectedIndex]
                label.textColor = selectedLabelColor
                
                circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y:0, width: imageSize  , height: imageSize )).cgPath
                circleLayer.position = CGPoint(x: a.frame.width/2-imageSize/2, y: imageTopInset-imageSize/2)
                imageViews[index].layer.mask = circleLayer
                
                scaleUpLayer (index: index)
                
            }
        }
        
        
    }
    
    func scaleUpLayer (index : Int){
        
        let a = imageViews[index].frame.width/2
        let newCircle = UIBezierPath(arcCenter: CGPoint(x: a, y: imageTopInset), radius: self.bounds.width, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
     
        
        newCircle.append(UIBezierPath(rect: self.bounds))
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = circleLayer.path
        animation.toValue = newCircle.cgPath
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.add(animation, forKey: nil)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        circleLayer.path = newCircle.cgPath
        CATransaction.commit()
    }
    
    
    func addIndividualItemConstraints(_ items: [UIView], mainView: UIView, padding: CGFloat) {
        
        for (index, button) in items.enumerated() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == items.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -padding)
                
            }else{
                
                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: nextButton, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: -padding)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: padding)
                
            }else{
                
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: prevButton, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: padding)
                
                let firstItem = items[0]
                
                let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: NSLayoutRelation.equal, toItem: firstItem, attribute: .width, multiplier: 1.0  , constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    func addIndividualItemConstraintsForLabels(_ items: [UIView], mainView: UIView, padding: CGFloat,labelHeight : CGFloat) {
        
        for (index, button) in items.enumerated() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: labelHeight)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == items.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -padding)
                
            }else{
                
                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: nextButton, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: -padding)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: padding)
                
            }else{
                
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: prevButton, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: padding)
                
                let firstItem = items[0]
                
                let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: NSLayoutRelation.equal, toItem: firstItem, attribute: .width, multiplier: 1.0  , constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
    
}


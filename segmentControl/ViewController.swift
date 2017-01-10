//
//  ViewController.swift
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

class ViewController: UIViewController {

    @IBOutlet weak var seg2: MySegment!
    @IBOutlet weak var seg: MySegment!
    @IBOutlet weak var seg3: MySegment!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seg.imageToAdd = ["Aerosol", "Generic", "Injection", "Drop"]
        seg.colorArray = [.red ,.blue, .orange,.green]
        seg.labelText = ["Aerosol", "Generic", "Injection", "Drop"]
        seg.setupView()
        
        seg2.imageToAdd = ["Oral Sospension", "Suppository"]
        seg2.colorArray = [.red ,.blue]
        seg2.labelText = ["Oral Sospension", "Suppository"]
        seg2.setupView()
        
        seg3.imageToAdd = ["Oral Sospension", "Suppository"]
        seg3.colorArray = [.red ,.blue]
        seg3.labelText = ["Oral Sospension", "Suppository"]
        seg3.setupView()
        
    }
    
    
    @IBAction func segAct(_ sender: MySegment) {
        
        
        
        switch seg.selectedIndex {
        case 0: label.text = seg.labelText[seg.selectedIndex]
        case 1: label.text = seg.labelText[seg.selectedIndex]
        case 2: label.text = seg.labelText[seg.selectedIndex]
        case 3:label.text = seg.labelText[seg.selectedIndex]
         default:
            break
        }

        
       
        }
        
    
    
    @IBAction func seg2Act(_ sender: MySegment) {
         switch seg2.selectedIndex {
        case 0: label.text = seg2.labelText[seg2.selectedIndex]
        case 1: label.text = seg2.labelText[seg2.selectedIndex]
       
            
        default:
            break}
        
        
    }
    
    @IBAction func seg3Act(_ sender: MySegment) {
        switch seg3.selectedIndex {
        case 0: label.text = seg3.labelText[seg3.selectedIndex]
        case 1: label.text = seg3.labelText[seg3.selectedIndex]
            
            
        default:
            break}
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


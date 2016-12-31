## FR76SegmentedCoctrol

## Screenshot

![alt tag](https://github.com/fred76/FR76SegmentedCoctrol/blob/master/screenshot.gif)

## Requirements

Xcode V. 8.1

iOS 10.1  
Swift 3

## Installation

Just add the FR76SegmentedCoctrol folder to your project.

## Usage

FR76SegmentedCoctrol is subclass of UIControl as replacement of UISgmentedControl. 
create a UIview and assign "MySegment" class

     
      override func viewDidLoad() {
        super.viewDidLoad()
        // add image
        seg.imageToAdd = ["Aerosol", "Generic", "Injection", "Drop"]
        // choose color
        seg.colorArray = [.red ,.blue, .orange,.green]
        // label title
        seg.labelText = ["Aerosol", "Generic", "Injection", "Drop"]
        // setUp the view
        seg.setupView()}
        

Setup Image position selected and unselected color text and label size as @IBInspectable value

![alt tag](https://github.com/fred76/FR76SegmentedCoctrol/blob/master/insp.jpeg)



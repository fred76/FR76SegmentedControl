## FR76SegmentedCoctrol

###

Version 8.1

iOS 10.1  

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
        


    
 

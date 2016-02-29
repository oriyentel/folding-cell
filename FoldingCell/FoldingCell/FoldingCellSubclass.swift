//
//  FoldingCellSubclass.swift
//  FoldingCell
//
//  Created by Joshua O'Steen on 2/29/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class FoldingCellSubclass: FoldingCell {

    
    override func awakeFromNib() {
        
        // Indicates the number of folds the cell has when (un)folding (can also be set in User Defined Runtime Attributes in Storyboard) (Declared in superclass)
        self.itemCount = 4
        
        // The color of the back of the cell as it's (un)folding (Declared in superclass)
        self.backViewColor = UIColor.darkGrayColor()
        
        // (OPTIONAL) Set a corner radius and bounding mask to the cell (can also be set in User Defined Runtime Attributes in Storyboard)
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        super.awakeFromNib()
    }
    
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        // REQUIRED: durations.count == self.itemCount
        let durations = [0.4, 0.2, 0.2, 0.2]
        assert(durations.count == self.itemCount)
        return durations[itemIndex]
    }

    

}

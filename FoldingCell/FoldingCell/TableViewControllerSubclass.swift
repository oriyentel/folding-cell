//
//  TableViewControllerSubclass.swift
//  FoldingCell
//
//  Created by Joshua O'Steen on 2/29/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class TableViewControllerSubclass: UITableViewController {
    
    // The height of the closed cell
    // This should include the height of the "Closed Cell View" + any upper margin constraint (10 in this case) + any lower margin constraint (10 in this case)
    let kCloseCellHeight: CGFloat = 120
    
    // The height of the open cell
    // This should include the height of the "Open Cell View" + any upper margin constraint (10 in this case) + any lower margin constraint (10 in this case)
    let kOpenCellHeight: CGFloat = 320
    
    // The number of cells to display in the table
    let kRowsCount = 10
    
    // Holds the cell heights for each closed cell
    var cellHeights = [CGFloat]()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the array of closed cell heights
        self.cellHeights = Array(count: self.kRowsCount, repeatedValue: self.kCloseCellHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.kRowsCount
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCellSubclass", forIndexPath: indexPath) as! FoldingCell
        
        // Configure the cell here

        return cell
    }

    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCellSubclass {
            if let foldingCell = cell as? FoldingCellSubclass {
                if self.cellHeights[indexPath.row] == kCloseCellHeight {
                    foldingCell.selectedAnimation(false, animated: false, completion:nil)
                } else {
                    foldingCell.selectedAnimation(true, animated: false, completion: nil)
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.cellHeights[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCellSubclass
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if self.cellHeights[indexPath.row] == self.kCloseCellHeight { // open cell
            self.cellHeights[indexPath.row] = self.kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            self.cellHeights[indexPath.row] = self.kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
        
        
    }

}

//
//  StudyTableViewController.swift
//  Baito_Swift
//
//  Created by Robert Lyons on 6/24/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class StudyTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var studySet: Set?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        print(studySet?.name)
        print(studySet?.terms)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studySet!.terms.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "StudyTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
           forIndexPath: indexPath) as! StudyTableViewCell

        // Fetches the appropriate set for the data source layout.
        let currentTerm = studySet!.terms[indexPath.row]
        
        // Configure cell
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        // initialize front and back of card
        let cardRect = CGRectMake(0, 0, cell.contentView.bounds.size.width - 15, cell.card.bounds.size.height)
        //print("Content View: " + String(cell.contentView))
        
        cell.front = UIView(frame: cardRect)
        cell.back = UIView(frame: cardRect)
        //cell.front.backgroundColor = UIColor.redColor()
        //cell.back.backgroundColor = UIColor.redColor()
        
        // initialize text on front and back
        let cardSize = cell.card.bounds.size
        let textRect = CGRectMake(cardSize.width / 2, cardSize.height / 2, cardSize.width / 2, cardSize.height / 2)
        
        let frontContent = VerticallyCenteredTextView(frame: textRect)
        let backContent = VerticallyCenteredTextView(frame: textRect)
        
        frontContent.center = cell.front.convertPoint(cell.front.center, fromView: cell.front.superview)
        backContent.center = cell.back.convertPoint(cell.back.center, fromView: cell.back.superview)
        
        //frontContent.backgroundColor = UIColor.blueColor()
        //backContent.backgroundColor = UIColor.blueColor()
        backContent.textAlignment = .Center
        frontContent.textAlignment = .Center
        frontContent.text = currentTerm.term
        backContent.text = currentTerm.definition
        frontContent.editable = false
        backContent.editable = false
        
        cell.front.addSubview(frontContent)
        cell.back.addSubview(backContent)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(StudyTableViewController.cardTap(_:)))
        singleTap.numberOfTapsRequired = 1
        
        cell.card.addGestureRecognizer(singleTap)
        cell.card.userInteractionEnabled = true
        
        cell.card.addSubview(cell.front)
        
        print("front: " + String(cell.front))
        print("back: " + String(cell.back))

        return cell
    }
    
    // MARK: Card flipping
    
    func cardTap(sender: UITapGestureRecognizer) {
        print("card tapped")
        let currentCell = sender.view!.superview?.superview as! StudyTableViewCell
        if (currentCell.showingFront) {
            print(currentCell.back)
            UIView.transitionFromView(currentCell.front, toView: currentCell.back, duration: 0.6,
                options: [.TransitionFlipFromLeft], completion: nil)
        } else {
            print(currentCell.front)
            UIView.transitionFromView(currentCell.back, toView: currentCell.front, duration: 0.6,
                options: [.TransitionFlipFromRight], completion: nil)
        }
        currentCell.showingFront = !currentCell.showingFront
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}

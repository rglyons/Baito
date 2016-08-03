//
//  TermDefTableViewController.swift
//  Baito_Swift
//
//  Created by Robert Lyons on 5/29/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class TermDefTableViewController: UITableViewController {
    
    //MARK: Properties --------------------------------------------------------------------------------
    
    var terms = [Term?]()
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var setName: UITextField!
    @IBOutlet var TermDefTable: UITableView!
    var NewSet: Set?    // Set that is created once the 'Save' button is pressed
    let termDefToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))         // create a new toolbar for adding empty terms
                                                                                        // quickly from keyboard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // display Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // load empty terms
        loadSampleSets()
        // configure custom keyboard
        newTermButtonOnKeyboard(termDefToolbar)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helper functions -------------------------------------------------------------------------
    
    func loadSampleSets() {
        //display empty term/def boxes
        let term1 = Term(term: "", definition: "")
        let term2 = Term(term: "", definition: "")
        let term3 = Term(term: "", definition: "")
        
        terms += [term1, term2, term3]
    }
    
    // MARK: Custom Keyboard --------------------------------------------------------------------------
    
    // configure custom toolbar for keyboard -
    // add button to keyboard for appending a blank term-def cell at the bottom of the tableView
    func newTermButtonOnKeyboard(toolbar: UIToolbar) {
        // blank space on left
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        // 'plus' button on right, calls addNewTerm() when pressed
        let newTermButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(TermDefTableViewController.addNewTerm))
        
        // add buttons to the button list
        var toolBarItems = [UIBarButtonItem]();
        toolBarItems += [flexSpace, newTermButton]
        
        // set toolbar's buttons to those in the button list
        toolbar.setItems(toolBarItems, animated: true)
        toolbar.sizeToFit()
    }
    
    // create and add to tableView a new empty term-def cell - called from button on custom keyboard
    func addNewTerm() {
        // create a new empty Term object
        let newTerm = Term(term: "", definition: "")
        // add new Term object at the back of the terms list
        terms.append(newTerm)
        
        // Update Table Data
        TermDefTable.beginUpdates()
        TermDefTable.insertRowsAtIndexPaths([                           // create new IndexPath at bottom of
                NSIndexPath(forRow: terms.count-1, inSection: 0)],      // tableView and put a new cell in it
                withRowAnimation: .Automatic)                           // animate addition of new cell
        TermDefTable.endUpdates()
    }
    
    // MARK: - Table view data source -----------------------------------------------------------------

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TermDefTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
                                                        forIndexPath: indexPath) as! TermDefTableViewCell

        // Fetches the appropriate set for the data source layout.
        let currentTerm = terms[indexPath.row]
        
        // Configure cell
        cell.termTextField.text = currentTerm?.term
        cell.definitionTextField.text = currentTerm?.definition
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        // set the keyboard for each textView in each cell to use the custom toolbar
        cell.termTextField.inputAccessoryView = termDefToolbar
        cell.definitionTextField.inputAccessoryView = termDefToolbar
        
        return cell
    }
    
    // MARK: Navigation --------------------------------------------------------------------------------
    
    // This method lets you configure a view controller before it's presented.
    // initialize NewSet to send to SetTableViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            /* iterate through the term-def cells and create a list of Term objects */
            // get all of the term-def cells
            let termDefCells = tableView.visibleCells as! [TermDefTableViewCell];
            // empty list of terms to build on to create the set
            var termsList = [Term]();
            // iterate through table and build list of Term objects
            for c in termDefCells {
                // either the term or definition must be present to create and add the Term obj to the termsList
                if (c.termTextField.text != "" || c.definitionTextField.text != "") {
                    let currentTerm: Term = Term(term: c.termTextField.text ?? "", definition: c.definitionTextField.text ?? "")!;
                    termsList += [currentTerm];
                }
            }
            
            // initialize the new set to be added to the Set List in SetListTableViewController.swift
            // don't add the set if it is empty (no name AND no terms/definitions)
            
            // Check for set name. nil coalescing wouldn't work (because empty string "" != nil)
            // if the set has a name, and/or at least one term, create it
            // name is 'New Set' if no name is provided
            // otherwise leave NewSet nil so it is not added to the Set List
            
            if !setName.text!.isEmpty {
                NewSet = Set(name: setName.text!, terms: termsList);
            } else if setName.text!.isEmpty && termsList.count != 0 {
                NewSet = Set(name: "New Set", terms: termsList);
            }
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            terms.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

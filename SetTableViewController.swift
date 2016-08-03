//
//  SetTableViewController.swift
//  Baito_Swift
//
//  Created by Robert Lyons on 5/24/16.
//  Copyright © 2016 Robert Lyons. All rights reserved.
//

import UIKit

class SetTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var sets = [Set]()
    var searchResults = [Set?]()
    //var currentSet: Set?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Load any saved sets, otherwise load sample data.
        if let savedSets = loadSets() {
            sets += savedSets
        } else {
            //load the sample set data
            loadSampleSets()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helper Functions
    
    // sample data for visualizing table of sets
    func loadSampleSets() {
        let term1 = Term(term: "むすこ", definition: "son");
        let term2 = Term(term: "むすめ", definition: "daughter")
        
        let set1 = Set(name: "Japanese 1", terms: [term1!])!
        let set2 = Set(name: "Japanese 2", terms: [term1!, term2!])!

        sets += [set1, set2]
    }
    
    // MARK: Search Bar ----------------------------------------------------------------------------------------------------------------
    
    // filter search results from search bar form set list
    func filterContentForSearchText(searchText: String) {
        let resultPred = NSPredicate(format: "name contains %@", searchText)
        searchResults = sets.filter { resultPred.evaluateWithObject($0) }
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }

    // MARK: Table view data source ----------------------------------------------------------------------------------------------------

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of rows to display in the table is the number of sets in the sets array
        if (tableView == self.searchDisplayController!.searchResultsTableView) {
            return searchResults.count;
        } else {
            return sets.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "SetListTableViewCell"
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
                                                forIndexPath: indexPath) as! SetListTableViewCell

        // Fetches the appropriate set for the data source layout.
        var set: Set? = nil
        if (tableView == self.searchDisplayController!.searchResultsTableView) {
            set = searchResults[indexPath.row]
        } else {
            set = sets[indexPath.row]
        }
        
        // Configure cell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.setNameButton.setTitle(set?.name, forState: .Normal)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // For consistent cell height when searching
        return 40
    }
    
    // finish later
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView.editing) {
            print("edit cell")
        }
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            sets.removeAtIndex(indexPath.row)
            saveSets()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
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
    
    // MARK: Navigation ----------------------------------------------------------------------------------------------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "SegueToStudyView",
            let destination = segue.destinationViewController as? StudyTableViewController,
            let selection = tableView.indexPathForSelectedRow?.row
        {
            destination.studySet = sets[selection]
        }
        print("Preparing for segue from SetTableView to StudyTableView")
    }
    
    // receive new set from TermDefTableViewController.swift and add it to Set List
    @IBAction func unwindToSetList(sender: UIStoryboardSegue) {
        // downcast sourceViewController to TermDefTableViewController so we can access NewSet
        if let sourceViewController = sender.sourceViewController as? TermDefTableViewController, NewSet = sourceViewController.NewSet {
            // compute location in TableView to put NewSet
            let newIndexPath = NSIndexPath(forRow: sets.count, inSection: 0)
            // Add the new Set to list of sets
            sets.append(NewSet);
            // Add new cell in TableView at the bottom for NewSet
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        print(sets.count)
        saveSets()
    }
    
    //MARK: NSCoding -------------------------------------------------------------------------------------------------------------------
    
    func saveSets() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(sets, toFile: Set.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save sets...")
        }
    }
    
    func loadSets() -> [Set]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Set.ArchiveURL.path!) as? [Set]
    }

}

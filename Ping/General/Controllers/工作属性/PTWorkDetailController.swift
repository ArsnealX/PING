//
//  PTWorkDetailController.swift
//  Ping
//
//  Created by datayes on 16/4/29.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import UIKit

class PTWorkDetailController: UITableViewController {
    var workStatus:PTWorkStatus!
    enum PTWorkStatus {
        case workStatusExecute
        case workStatusVerify
        case workStatusNotice
     }
    
    
    @IBOutlet weak var closeCell: UITableViewCell!
    @IBOutlet weak var modifyCell: UITableViewCell!
    @IBOutlet weak var quiteCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.workStatus = PTWorkStatus.workStatusExecute
    }
  
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 12
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
         return UIView();
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.workStatus == PTWorkStatus.workStatusExecute {
            if section == 1 {
                return 1
            }
            if section == 2 {
                return 2
            }
        } else if self.workStatus == PTWorkStatus.workStatusVerify {
            if section == 1 {
                return 2
            }
            if section == 2 {
                return 1
            }
            if section == 4 {
                return 2
            }
        }else if self.workStatus == PTWorkStatus.workStatusNotice {
            return 1
        }
        if section == 4 {
            return 1
        }
        return  super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 4 {
            if self.workStatus == PTWorkStatus.workStatusExecute{
                return closeCell
            }else if self.workStatus == PTWorkStatus.workStatusVerify {
                if indexPath.row == 0 {
                    return closeCell
                }
                return modifyCell
            }else if self.workStatus == PTWorkStatus.workStatusNotice
            {
                return quiteCell
            }
        }
      return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.performSegueWithIdentifier("workNameIdentifer", sender: self)
            }else {
                self.performSegueWithIdentifier("contentIndentifier", sender: self)
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
            }else {
                self.performSegueWithIdentifier("workHardIdentifier", sender: self)
            }
        }else if indexPath.section == 2 {
            if indexPath.row == 0 {
            }else {
                self.performSegueWithIdentifier("wordStausIdentifer", sender: self)
            }
        }else if indexPath.section == 3 {
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
 
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

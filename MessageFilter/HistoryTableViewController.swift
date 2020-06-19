//
//  HistoryTableViewController.swift
//  MessageFilter
//
//  Created by zhaoyang on 2020/6/16.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit
import MessageFilterKit
class HistoryTableViewController: UITableViewController {

    let historyData = DataStoreManager.allData() ?? [:]
    var historyKeys: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        historyKeys = historyData.allKeys as? [String]
        historyKeys = historyKeys.sorted()
        
        print(historyKeys as Any)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return historyKeys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = historyKeys[section]
        let values = historyData[key] as! NSArray
        return values.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        lbl.text = historyKeys[section]
        lbl.backgroundColor = .lightGray
        return lbl
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.selectionStyle = .none

        // Configure the cell...
        let key = historyKeys[indexPath.section]
        let values = historyData[key] as! NSArray
        let filterInfo = values[indexPath.row] as! FilterInfo
        cell.textLabel?.text = filterInfo.saveMessage()
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let key = historyKeys[indexPath.section]
            let values = historyData[key] as? NSArray
            if let value = values {
                let mValues = value.mutableCopy() as! NSMutableArray
                mValues.removeObject(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } 
    }
    
*/
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

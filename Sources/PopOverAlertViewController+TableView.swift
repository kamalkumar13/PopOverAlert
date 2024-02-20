//
//  PopOverAlertViewController
//

import Foundation

extension PopOverAlertViewController {
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell")!
                cell.textLabel?.text = messege
                cell.textLabel?.font = messageFont
                
                if let subMessage = self.subMessage {
                    cell.detailTextLabel?.text = subMessage
                    cell.detailTextLabel?.font = subMessageFont
                }
                
                cell.textLabel?.textColor = .white
                
                cell.detailTextLabel?.textColor = .white
                cell.detailTextLabel?.isHidden = true
                
                return cell
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell")!
                cell.textLabel?.text = buttonText
                cell.textLabel?.font = buttonTextFont
                cell.textLabel?.textColor = buttonTextColor
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                cell.textLabel?.textAlignment = .right
                
                return cell
            }
        }
        
        return UITableViewCell()
    }

    override open func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                self.dismiss(animated: true, completion: {
                    if let handler = self.completionHandler {
                        handler()
                    }
                })
            }
        }
    }
}

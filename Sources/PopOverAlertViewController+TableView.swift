//
//  PopOverAlertViewController
//

import Foundation

extension PopOverAlertViewController {
    
    override open func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        } else {
            return 0
        }
    }
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
            view.backgroundColor = .clear
            return view
        } else {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
            view.backgroundColor = .clear
            return view
        }
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 30
        }
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell")!
                
                let textLabel = cell.viewWithTag(101) as! UILabel
                textLabel.text = messege
                textLabel.font = messageFont
                textLabel.textColor = .white
                textLabel.textAlignment = .left
                                
                
//                let detailTextLabel = cell.viewWithTag(102) as! UILabel
//                if let subMessage = self.subMessage {
//                    detailTextLabel.text = subMessage
//                    detailTextLabel.font = subMessageFont
//                }
//                detailTextLabel.textColor = .white
//                detailTextLabel.isHidden = true

                cell.selectionStyle = .none
                                
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
                
                cell.selectionStyle = .none
                
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

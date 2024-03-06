//
//  PopOverAlertViewController
//

import Foundation

open class PopOverAlertViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {
    
    var messege: String?
    var subMessage: String?
    var buttonText:String?
    
    var messageFont = UIFont.systemFont(ofSize: 14)
    var buttonTextFont = UIFont.systemFont(ofSize: 14)
    var subMessageFont = UIFont.systemFont(ofSize: 12)
    var buttonTextColor = UIColor.white

    @objc open var completionHandler: (() -> Void)?
    
    private var separatorStyle: UITableViewCell.SeparatorStyle = UITableViewCell.SeparatorStyle.none
    private var showsVerticalScrollIndicator:Bool = false
        
    @objc public static func instantiate() -> PopOverAlertViewController {
        let storyboardsBundle = getStoryboardsBundle()
        let storyboard:UIStoryboard = UIStoryboard(name: "PopOverAlert", bundle: storyboardsBundle)
        let popOverAlertViewController = storyboard.instantiateViewController(withIdentifier: "PopOverAlertViewController") as! PopOverAlertViewController
        
        popOverAlertViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        popOverAlertViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        
        // arrow color
        popOverAlertViewController.popoverPresentationController?.backgroundColor = UIColor.clear
        
        return popOverAlertViewController
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        tableView.separatorStyle = separatorStyle
        tableView.accessibilityIdentifier = "PopOverAlertTableView"
         
        let color1 = UIColor(red: 0.352, green: 0.295, blue: 1, alpha: 1)
        let color2 = UIColor(red: 0.55, green: 0.489, blue: 0.926, alpha: 1)

        let averageRed = (color1.r + color2.r) / 2
        let averageGreen = (color1.g + color2.g) / 2
        let averageBlue = (color1.b + color2.b) / 2

        let blendedColor = UIColor(red: averageRed, green: averageGreen, blue: averageBlue, alpha: 1.0)


        
        view.backgroundColor = blendedColor //UIColor(red: 0.352, green: 0.295, blue: 1, alpha: 1)
        self.addBackgroundPopup()
    }
    
    func addBackgroundPopup() {
        
        // Auto layout, variables, and unit scale are not yet supported
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height)
        var shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        view.addSubview(shapes)

        let layer1 = CAGradientLayer()
        layer1.colors = [
          UIColor(red: 0.352, green: 0.295, blue: 1, alpha: 1).cgColor,
          UIColor(red: 0.55, green: 0.489, blue: 0.926, alpha: 1).cgColor
        ]
        layer1.locations = [0.28, 1]
        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.08, b: 0.91, c: -0.99, d: 10.37, tx: 0.41, ty: -5.07))
        layer1.bounds = shapes.bounds.insetBy(dx: -0.5*shapes.bounds.size.width, dy: -0.5*shapes.bounds.size.height)
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)


        tableView.backgroundView = view
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            view.widthAnchor.constraint(equalToConstant: tableView.frame.size.width).isActive = true
            view.heightAnchor.constraint(equalToConstant: tableView.frame.size.height).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let footerView = tableView.tableFooterView {
            let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            
            if height != footerView.frame.size.height {
                tableView.tableFooterView?.frame.size.height = height
            }
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc open func setMessage(_ message:String) {
        self.messege = message
    }
    
    @objc open func getMessage() -> String {
        return self.messege ?? ""
    }
    
    @objc open func setSubMessage(_ subMessage:String) {
        self.subMessage = subMessage
    }
    
    @objc open func setButtonText(_ buttonText:String) {
        self.buttonText = buttonText
    }
    
    @objc open func setMessageFont(_ messageFont:UIFont) {
        self.messageFont = messageFont
    }
    
    @objc open func setSubMessageFont(_ subMessageFont:UIFont) {
        self.subMessageFont = subMessageFont
    }
    
    @objc open func setButtonTextFont(_ buttonTextFont:UIFont) {
        self.buttonTextFont = buttonTextFont
    }
    
    @objc open func setButtonTextColor(_ buttonTextColor:UIColor) {
        self.buttonTextColor = buttonTextColor
    }
    
    @objc open func setSeparatorStyle(_ separatorStyle:UITableViewCell.SeparatorStyle) {
        self.separatorStyle = separatorStyle
    }
    
    @objc open func setShowsVerticalScrollIndicator(_ showsVerticalScrollIndicator:Bool) {
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    }
    
    static func getStoryboardsBundle() -> Bundle {
        let podBundle = Bundle(for: PopOverAlertViewController.self)
        let bundleURL = podBundle.url(forResource: "PopOverAlertStoryboards", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        
        return bundle
    }
}

extension UIColor {
    var r: CGFloat {
        var red: CGFloat = 0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return red
    }

    var g: CGFloat {
        var green: CGFloat = 0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return green
    }

    var b: CGFloat {
        var blue: CGFloat = 0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return blue
    }
}

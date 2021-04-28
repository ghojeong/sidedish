//
//  DetailViewController.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/28.
//

import UIKit

class DetailViewController: UIViewController/*, ViewChangable*/{
    
    @IBOutlet weak var navigationTItle: UINavigationItem!
    @IBOutlet weak var detailMainImage: UIImageView!
    @IBOutlet weak var detailMainTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailSalePrice: UILabel!
    @IBOutlet weak var detailOriginprice: UILabel!
    
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var deliveryInfo: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    
//    private var mainViewController: MainViewController!
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nil, bundle: nil)
//        self.mainViewController = storyboard?.instantiateViewController(withIdentifier: IdentifierControllers.main.rawValue) as? MainViewController
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        self.mainViewController = storyboard?.instantiateViewController(withIdentifier: IdentifierControllers.main.rawValue) as? MainViewController
//        mainViewController.set(delegate: self)
//    }
    override func loadView() {
        
        super.loadView()
    }
    
    private func bindViewModelProperties() {
        
    }
}

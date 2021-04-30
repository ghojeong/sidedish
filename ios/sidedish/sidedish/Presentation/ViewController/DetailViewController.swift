//
//  DetailViewController.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/28.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
       
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var detailMainImage: UIImageView!
    @IBOutlet weak var detailMainTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailSalePrice: UILabel!
    @IBOutlet weak var detailOriginprice: UILabel!
    @IBOutlet weak var thumbnailImages: UIStackView!
    @IBOutlet weak var detailImages: UIStackView!
    @IBOutlet weak var thumbnailscrollView: UIScrollView!
    @IBOutlet weak var detailScrollView: UIView!
    
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var deliveryInfo: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    
    private var viewModel: DetailViewModel
    private var subscription = Set<AnyCancellable>()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = DetailViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = DetailViewModel()
        super.init(coder: coder)
    }
    
    override func loadView() {
        bindViewModelProperties()
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModelProperties() {
        viewModel.$sideDishDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let SideDishDetail = self?.viewModel.sideDishDetail else { return }
                self?.navigationTitle.title = SideDishDetail.getTitle()
                self?.detailMainTitle.text = SideDishDetail.getTitle()
                let imageView = UIImageView(image: UIImage(contentsOfFile: SideDishDetail.getThumbnailPath() ?? ""))
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.widthAnchor.constraint(equalToConstant: (self?.thumbnailscrollView.frame.width)!).isActive = true
                self?.thumbnailImages.addArrangedSubview(imageView)
                self?.detailDescription.text = SideDishDetail.getdescription()
                self?.detailSalePrice.text = String(describing: SideDishDetail.getPrice()) + "원"
                self?.detailOriginprice.text = String(describing: SideDishDetail.getPrice()) + "원"
                self?.point.text = String(describing: SideDishDetail.getDetail()!.point) + "원"
                self?.deliveryInfo.text = SideDishDetail.getDetail()!.deliveryInfo
                self?.deliveryFee.text = String(describing: SideDishDetail.getDetail()!.deliveryFee) + "원"
                self?.thumbnailImages.translatesAutoresizingMaskIntoConstraints = false
                for i in 0..<(self?.viewModel.sideDishDetail.getDetail()?.thumbImages.count)! {
                    DispatchQueue.global().async {
                        guard let url = URL(string: (self?.viewModel.sideDishDetail.getDetail()?.thumbImages[i])!) else { return }
                        let data = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            if let tempdata = data {
                                let imageView = UIImageView(image: UIImage(data: tempdata))
                                imageView.translatesAutoresizingMaskIntoConstraints = false
                                imageView.widthAnchor.constraint(equalToConstant: (self?.thumbnailscrollView.frame.width)!).isActive = true
                                self?.thumbnailImages.addArrangedSubview(imageView)
                            }
                        }
                    }
                }
                for i in 0..<(self?.viewModel.sideDishDetail.getDetail()?.detailImages.count)! {
                    DispatchQueue.global().async {
                        guard let url = URL(string: (self?.viewModel.sideDishDetail.getDetail()?.detailImages[i])!) else { return }
                        let data = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            if let tempdata = data {
                                let imageView = UIImageView(image: UIImage(data: tempdata))
                                imageView.translatesAutoresizingMaskIntoConstraints = false
                                imageView.widthAnchor.constraint(equalToConstant: (self?.thumbnailscrollView.frame.width)!).isActive = true
                                imageView.heightAnchor.constraint(equalToConstant: (self?.thumbnailscrollView.frame.height)!).isActive = true
                                self?.detailImages.addArrangedSubview(imageView)
                            }
                        }
                    }
                }
            }.store(in: &subscription)
    }
    
    func viewModelConfigure(section: Int, row: Int) {
        viewModel.configureDetailMenuBoard(section: section, row: row) { }
    }
}

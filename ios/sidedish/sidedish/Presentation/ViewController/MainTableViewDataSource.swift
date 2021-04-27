//
//  MainTableViewDataSource.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/19.
//

import UIKit

class MainTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let menuCellViewModel: MenuCellViewModel
    
    init(menucellViewModel: MenuCellViewModel) {
        self.menuCellViewModel = menucellViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuCellViewModel.sideCategoryCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCellViewModel.sideDishesCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else { return UITableViewCell() }
        
        let dishProperty = menuCellViewModel.dishes[indexPath.section][indexPath.row]
        
        cell.updateMenu(image: UIImage(),
                        titleText: dishProperty.title,
                        subTitle: dishProperty.description,
                        price: dishProperty.price,
                        reducedPrice: dishProperty.salePrice,
                        badge: dishProperty.badges ?? ["",""])
        
        DispatchQueue.global().async {
            let url = URL(string: dishProperty.image)!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let tempdata = data {
                    cell.menuImage.image = UIImage(data: tempdata)
                }
            }
        }
        return cell
    }
}
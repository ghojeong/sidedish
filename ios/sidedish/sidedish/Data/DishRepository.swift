//
//  Repository.swift
//  sidedish
//
//  Created by 박정하 on 2021/04/25.
//

import CoreData
import Combine

final class DishRepository {
    
    private let coreData = CoreDataStorage.shared
    private var context : NSManagedObjectContext!
    private var sideDishEntity : NSEntityDescription!
    private var categoryEntity : NSEntityDescription!
    private var detailEntity : NSEntityDescription!
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let networkManager: AFNetworkManagable!
    private let imageDownloadManager: ImageDownloadManager!
    
    init(with url: String) {
        self.context = coreData.persistentContainer.viewContext
        self.sideDishEntity = NSEntityDescription.entity(forEntityName: SaveSideDish.Properties.entity, in: context)
        self.categoryEntity = NSEntityDescription.entity(forEntityName: SaveSideDishes.Properties.entity, in: context)
        self.detailEntity = NSEntityDescription.entity(forEntityName: SaveDetail.Properties.entity, in: context)
        self.networkManager = NetworkManager(with: url)
        self.imageDownloadManager = ImageDownloadManager()
    }
    //MARK: - category
    
    func getCategories(completionHandler: @escaping (Just<[SideDishesCategoryManageable]>) -> ()) {
        
        if let categorySaved = loadCategories() {
            return completionHandler(Just(categorySaved))
        }
        
        let categories = networkManager.get(decodingType: [SideDishesCategory].self,
                                            endPoint: EndPoint.categories)
        
        categories.sink { (_) in
        } receiveValue: { categories in
            if let categoryEntity = self.categoryEntity {
                categories.forEach {
                    let sideDishCategory = NSManagedObject(entity: categoryEntity, insertInto: self.context)
                    sideDishCategory.setValue($0.id, forKey: SaveSideDishes.Properties.id)
                    sideDishCategory.setValue($0.categoryName, forKey: SaveSideDishes.Properties.categoryName)
                    sideDishCategory.setValue($0.endPoint, forKey: SaveSideDishes.Properties.endPoint)
                }
                self.save()
                completionHandler(Just(self.loadCategories() ?? []))
            }
        }.store(in: &cancelBag)
    }
    
    private func save() {
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadCategories() -> [SideDishesCategoryManageable]? {
        let categories = try? context.fetch(SaveSideDishes.fetchRequest()) as? [SideDishesCategoryManageable]
        
        if let categories = categories, categories.isEmpty {
            return nil
        }
        
        return categories
    }
    
    
    //MARK: - sidedishes
    func getSideDishes(endPoint: String, completionHandler: @escaping (Just<[SideDishManageable]>) -> ()) {
        	
        if let sideDishesSaved = loadSideDishes(of: endPoint) {
            print("찾음")
            return completionHandler(Just(sideDishesSaved))
        }
        
        let mainSideDishes = networkManager.get(decodingType: [SideDish].self, endPoint: endPoint)
        
        mainSideDishes
            .receive(on: DispatchQueue.main)
            .sink { (_) in
        } receiveValue: { (dishes) in
            self.updateCategory(of: endPoint, with: dishes)
            self.save()
            completionHandler(Just(self.loadSideDishes(of: endPoint) ?? []))
        }.store(in: &cancelBag)
    }
    
    func getSideDishDetail(endPoint: String, section: Int, row: Int, completionHandler: @escaping (Just<SideDishManageable>) -> ()){
        
        if let sideDishSaved = loadSideDishes(of: endPoint)?[row], let _ = loadSideDishes(of: endPoint)?[row].getDetail() {
            return completionHandler(Just(sideDishSaved))
        }
        
        let sidedishDetailHash = self.loadSideDishes(of: endPoint)![row].getID()
        let mainSideDishDetail = networkManager.get(decodingType: SideDishDetail.self, endPoint: EndPoint.detail + "/\(sidedishDetailHash)")
        
        mainSideDishDetail.sink { (_) in
        } receiveValue: { (dishDetail) in
            self.updateDishDetail(endPoint: endPoint, row: row, with: dishDetail)
            self.save()
            completionHandler(Just(self.loadSideDishes(of: endPoint)![row]))
        }.store(in: &cancelBag)
    }
    
    private func updateCategory(of endPoint: String, with sideDishes: [SideDish]) {
        let fetchRequest = findSideDishes(query: Query.endPoint, match: endPoint)
        
        let objectToUpdate = try! self.context.fetch(fetchRequest).first!
        objectToUpdate.setValue(sideDishes, forKey: "sideDish")
    }
    
    private func updateDishDetail(endPoint: String, row: Int, with sideDishDetail: SideDishDetail) {
        let fetchRequest = findSideDishes(query: Query.endPoint, match: endPoint)
        let objectToUpdate = try! self.context.fetch(fetchRequest).first!
        objectToUpdate.sideDish![row].detail = sideDishDetail
    }
    
    private func loadSideDishes(of endPoint: String) -> [SideDishManageable]? {
        let fetchRequest = findSideDishes(query: Query.endPoint, match: endPoint)
        
        guard let targetCategory = try? context.fetch(fetchRequest) else {
            return nil
        }
        return targetCategory[0].sideDish
    }
    
    private func findSideDishes(query: Query, match: String) -> NSFetchRequest<SaveSideDishes> {
        let fetchRequest: NSFetchRequest<SaveSideDishes> = SaveSideDishes.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: query.value, match)
        return fetchRequest
    }
    
    enum Query: String {
        case endPoint = "endPoint == %@"
        
        var value: String {
            return rawValue
        }
    }
    
    //MARK: - thumbnail path
    func getSideDishThumbnailPath(from url: String, id: String, completionHandler: @escaping (Just<String>) -> ()) {
        imageDownloadManager.download(from: url, fileName: id) { (cachePath) in
            completionHandler(Just(cachePath))
        }
    }
    
    //MARK: - delete
    func deleteAllInCoreData(){
        let saveSideDishesRequest: NSFetchRequest<SaveSideDishes> = SaveSideDishes.fetchRequest()
        self.deleteAll(request: saveSideDishesRequest)
    }
    
    private func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        try! self.context.execute(delete)
    }
}

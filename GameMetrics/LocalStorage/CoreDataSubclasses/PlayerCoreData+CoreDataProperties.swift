
import Foundation
import CoreData


extension PlayerCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerCoreData> {
        return NSFetchRequest<PlayerCoreData>(entityName: "PlayerCoreData")
    }

    @NSManaged public var name: String
    @NSManaged public var isDotaType: Bool
    @NSManaged public var image: Data

}

extension PlayerCoreData : Identifiable {

}

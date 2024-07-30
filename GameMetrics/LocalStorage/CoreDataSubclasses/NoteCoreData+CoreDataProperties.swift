
import Foundation
import CoreData


extension NoteCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteCoreData> {
        return NSFetchRequest<NoteCoreData>(entityName: "NoteCoreData")
    }

    @NSManaged public var isDotaType: Bool
    @NSManaged public var name: String
    @NSManaged public var descriptionData: String
    @NSManaged public var tag: String
    @NSManaged public var color: [Double]

}

extension NoteCoreData : Identifiable {

}

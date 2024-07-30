
import Foundation
import CoreData


extension StatCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StatCoreData> {
        return NSFetchRequest<StatCoreData>(entityName: "StatCoreData")
    }

    @NSManaged public var isDotaType: Bool
    @NSManaged public var numberOfMatches: Int32
    @NSManaged public var tournamentPlace: Int32

}

extension StatCoreData : Identifiable {

}

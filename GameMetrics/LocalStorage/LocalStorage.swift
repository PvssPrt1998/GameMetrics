import Foundation

final class LocalStorage {
    
    private let modelName = "GameMetrics"
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    //MARK: - Save
    func savePlayer(_ player: Player) {
        let playerCoreData = PlayerCoreData(context: coreDataStack.managedContext)
        playerCoreData.image = player.image
        playerCoreData.isDotaType = player.isDotaType
        playerCoreData.name = player.name
        coreDataStack.saveContext()
    }
    
    func saveTeam(_ team: Team) {
        let teamCoreData = TeamCoreData(context: coreDataStack.managedContext)
        teamCoreData.logo = team.logo
        teamCoreData.title = team.title
        coreDataStack.saveContext()
    }
    
    func saveNote(_ note: Note) {
        let noteCoreData = NoteCoreData(context: coreDataStack.managedContext)
        noteCoreData.color = note.color
        noteCoreData.descriptionData = note.description
        noteCoreData.isDotaType = note.isDotaType
        noteCoreData.name = note.name
        noteCoreData.tag = note.tag
        coreDataStack.saveContext()
    }
    
    func saveStat(_ stat: Stat) {
        let statCoreData = StatCoreData(context: coreDataStack.managedContext)
        statCoreData.isDotaType = stat.isDotaType
        statCoreData.numberOfMatches = Int32(stat.numberOfMatches)
        statCoreData.tournamentPlace = Int32(stat.tournamentPlace)
        coreDataStack.saveContext()
    }
    
    func fetchPlayers() throws -> [Player] {
        var players: Array<Player> = []
        let playersCoreData = try coreDataStack.managedContext.fetch(PlayerCoreData.fetchRequest())
        playersCoreData.forEach { playerCoreData in
            players.append(Player(isDotaType: playerCoreData.isDotaType, image: playerCoreData.image, name: playerCoreData.name))
        }
        return players
    }
    
    func fetchTeam() throws -> Team? {
        guard let teamCoreData = try coreDataStack.managedContext.fetch(TeamCoreData.fetchRequest()).first else { return nil }
        return Team(logo: teamCoreData.logo, title: teamCoreData.title)
    }
    
    func fetchNotes() throws -> [Note] {
        var notes: Array<Note> = []
        let notesCoreData = try coreDataStack.managedContext.fetch(NoteCoreData.fetchRequest())
        notesCoreData.forEach { noteCoreData in
            notes.append(Note(isDotaType: noteCoreData.isDotaType,
                              name: noteCoreData.name,
                              description: noteCoreData.descriptionData,
                              tag: noteCoreData.tag, 
                              color: noteCoreData.color))
        }
        return notes
    }
    
    func fetchStats() throws -> [Stat] {
        var stats: Array<Stat> = []
        let statsCoreData = try coreDataStack.managedContext.fetch(StatCoreData.fetchRequest())
        statsCoreData.forEach { statCoreData in
            stats.append(Stat(isDotaType: statCoreData.isDotaType, numberOfMatches: Int(statCoreData.numberOfMatches), tournamentPlace: Int(statCoreData.tournamentPlace)))
        }
        return stats
    }
}

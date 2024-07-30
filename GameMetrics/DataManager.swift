import Foundation

protocol GameData {
    var players: Array<Player> { get set }
    var notes: Array<Note> { get set }
    var stat: Stat? { get set }
}

class GameDataBase: GameData {
    
    @Published var players: Array<Player> = []
    @Published var notes: Array<Note> = []
    @Published var stat: Stat?
    
    let localStorage: LocalStorage
    
    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
    }
    
    func setStat(numberOfMathces: Int, tournamentPlace: Int, isDotaType: Bool) {
        let stat = Stat(isDotaType: isDotaType, numberOfMatches: numberOfMathces, tournamentPlace: tournamentPlace)
        localStorage.saveStat(stat)
        self.stat = stat
    }
    
    func addPlayer(isDotaType: Bool, image: Data, name: String) {
        let player = Player(isDotaType: isDotaType, image: image, name: name)
        localStorage.savePlayer(player)
        players.append(player)
    }
    
    func addNote(isDotaType: Bool, name: String, description: String, tag: String, color: [Double]) {
        let note = Note(isDotaType: isDotaType, name: name, description: description, tag: tag, color: color)
        localStorage.saveNote(note)
        notes.append(note)
    }
}

final class DataManager: ObservableObject {
    
    let localStorage = LocalStorage()
    
    @Published var dataLoaded: Bool = false
    private var localDataLoaded: Bool = false
    
    var dotaData: GameDataBase
    var lolData: GameDataBase
    
    @Published var team: Team?
    
    init() {
        dotaData = DotaData(localStorage: localStorage)
        lolData = LolData(localStorage: localStorage)
    }

    func setTeam(logo: Data, title: String) {
        let team = Team(logo: logo, title: title)
        localStorage.saveTeam(team)
        self.team = team
    }
    
    func loadLocalData() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            if let players = try? localStorage.fetchPlayers() {
                players.forEach { player in
                    if player.isDotaType {
                        self.dotaData.players.append(player)
                    } else {
                        self.lolData.players.append(player)
                    }
                }
            }
            if let notes = try? localStorage.fetchNotes() {
                notes.forEach { note in
                    if note.isDotaType {
                        self.dotaData.notes.append(note)
                    } else {
                        self.lolData.notes.append(note)
                    }
                }
            }
            if let stats = try? localStorage.fetchStats() {
                stats.forEach { stat in
                    if stat.isDotaType {
                        self.dotaData.stat = stat
                    } else {
                        self.lolData.stat = stat
                    }
                }
            }
            self.team = try? localStorage.fetchTeam()
        }
    }
}

class DotaData: GameDataBase {
    
}

class LolData: GameDataBase {
    
}

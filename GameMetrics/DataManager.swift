import Foundation

protocol GameData {
    var players: Array<Player> { get set }
    var notes: Array<Note> { get set }
    var stat: Stat { get set }
}

class GameDataBase: GameData {
    @Published var players: Array<Player> = []
    @Published var notes: Array<Note> = []
    @Published var stat: Stat = Stat(numberOfMatches: 0, tournamentPlace: 0)
    
    func setStat(numberOfMathces: Int, tournamentPlace: Int) {
        stat = Stat(numberOfMatches: numberOfMathces, tournamentPlace: tournamentPlace)
    }
}

final class DataManager: ObservableObject {
    
    var dotaData: GameDataBase = DotaData()
    var lolData: GameDataBase = LolData()
    
    @Published var team: Team?
    @Published var players: Array<Player> = []
    @Published var notes: Array<Note> = []
    @Published var stat: Stat = Stat(numberOfMatches: 0, tournamentPlace: 0)
    
    func setTeam(logo: Data, title: String) {
        team = Team(logo: logo, title: title)
    }
    
    func setStat(numberOfMathces: Int, tournamentPlace: Int) {
        stat = Stat(numberOfMatches: numberOfMathces, tournamentPlace: tournamentPlace)
    }
}

class DotaData: GameDataBase {
    
}

class LolData: GameDataBase {
    
}

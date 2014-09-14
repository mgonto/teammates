//
//  Match.swift
//  TeamMates
//
//  Created by Guido Marucci Blas on 9/13/14.
//
//

import Foundation

class Match: Model {
    
    private let _date: NSDate
    private let _requiredPlayersAmount: Int
    private var _players: [Player] = []
    
    var date: NSDate {
        return _date
    }
    
    var playersCount: Int {
        return _players.count
    }
    
    var players: [Player] {
        return _players.map({ (player) -> Player in
            player
        })
    }
    
    var requiredPlayersAmount: Int {
        return _requiredPlayersAmount
    }
    
    init(_ date: NSDate, _ requiredPlayersAmount: Int) {
        self._date = date
        self._requiredPlayersAmount = requiredPlayersAmount
    }

    func isFull() -> Bool {
        return _players.count >= requiredPlayersAmount
    }
    
    func addPlayer(player: Player) {
        _players.append(player)
    }
    
    func removePlayer(player: Player) {
        for (index, element) in enumerate(_players) {
            if (element == player) {
                _players.removeAtIndex(index)
            }
        }
    }
    
    func plays(player: Player) -> Bool {
        return contains(_players, player)
    }
    
}
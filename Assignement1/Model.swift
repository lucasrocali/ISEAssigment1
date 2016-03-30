//
//  Model.swift
//  Assignement1
//
//  Created by Mateus Cirolini on 29/03/2015.
//  Copyright (c) 2015 RMIT. All rights reserved.
//

import Foundation

class Model {
    
    var db = DBSimulator()

    //Full list of Movies
    var allMovies:[Movie] = []

    var cinemas:[Cinema] = []
    
    //Singleton
    private struct Static {
        static var instance: Model?
    }
    
    class var sharedInstance: Model {
        if (Static.instance == nil) {
            Static.instance = Model()
        }
        return Static.instance!
    }
    
    //------------------
    
    init() {
        createMovies()
        createCinemas()
        fillSessions()
    }
    
    func createCinemas() {
        var numberOfCinemas = db.allCinemas.count
        var numberOfAllMovies = allMovies.count
        
        for cinema in db.allCinemas {
            cinemas.append(Cinema(name:cinema))
        }
    
        for indexCinema in 0..<numberOfCinemas {
            for indexMovie in 0..<numberOfAllMovies - indexCinema{
                cinemas[indexCinema].setMovie(allMovies[indexMovie])
            }
        }
    }

    func createMovies() {
        
        var numberOfAllMovies = db.allMoviesName.count
        for index in 0..<numberOfAllMovies {
            allMovies.append(Movie(name:db.allMoviesName[index],genre:db.allMoviesGenre[index],synopsis:db.allMoviesSynopsis[index]))
        }
    }
    
    func fillSessions() {
        var timeTable:[String] = []
        var numberOfCinemas = cinemas.count
        var numberOfSessions = 35 //7days 5 sesseions/day
        
        for indexCinema in 0..<numberOfCinemas {
            var numberOfMovies = cinemas[indexCinema].movies.count
            timeTable = []
            for indexSession in 0..<numberOfSessions {
                timeTable.append(cinemas[indexCinema].movies[indexSession%numberOfMovies].name)
                cinemas[indexCinema].movies[indexSession%numberOfMovies].sessions.append(Session(day: indexSession/5+1, time: indexSession%5+1))

            }
        }
    }
}
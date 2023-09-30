//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Rohit Deshmukh on 29/07/23.
//

// Alert to prompt the user to win or lose
// Choose between R P S and create an array based on whether the user chose lose or win

import SwiftUI

struct ContentView: View {
    
    // Available moves
    @State private var moves = ["✊", "✌️", "🖐️"]
    @State private var winMoves = ["🖐️", "✊", "✌️"]
    @State private var loseMoves = ["✌️", "🖐️", "✊"]
    
    // The player's move
    @State private var playerMove = 0
    
    // The game's move
    @State private var gamesMove = Int.random(in: 0...2)
    
    // The game's choice to let player win or not
    @State private var gameChoice = Bool.random()
    
    // A bool to show the alert for game choice
    @State private var showChoice = true
    
    // Number of turns limit
    private let turnLimit = 10
    
    // Bool to rest the game
    @State private var reset = false
    
    // Current number of turns
    @State private var turns = 0
    
    // The player's score
    @State private var score = 0
    
    var body: some View {
        
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.purple, .indigo, .blue, .teal, .green, .yellow, .orange, .red]), center: .center).ignoresSafeArea()
            
            VStack {
                Text("Rock Paper Scissor")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                Text("Game's Move: ")
                    .font(.headline.weight(.heavy))
                    .foregroundColor(.white)
                Text(moves[gamesMove])
                    .font(.system(size: 40))
                        .padding()
                        .background()
                        .clipShape(Circle())
                        .shadow(radius: 5)
                
                Spacer()
                
                Text("Your Move: ")
                    .font(.headline.weight(.heavy))
                    .foregroundColor(.white)
                HStack {
                    ForEach(0..<3){ number in
                        Button {
                            playerMove = number
                            checkResult(playerMove)
                        } label: {
                            Text(moves[number])
                                .font(.system(size: 70))
                                .padding()
                                .background()
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                    }
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.weight(.bold))
                
            }
            .alert("Game Choice", isPresented: $showChoice){
                Button("Continue", action: newTurn)
            } message: {
                if gameChoice == true {
                    Text("You have to WIN this game")
                } else {
                    Text("You have to LOSE this game")
                }
            }
            .alert("That's it", isPresented: $reset) {
                Button("Play Again", action: resetGame)
            } message: {
                Text("Your score was \(score)")
            }
        }
        
    }
    
    func checkResult(_ number: Int) {
        if gameChoice == true {
            if moves[gamesMove] == winMoves[number] {
                score += 1
                print("Player Wins")
            } else {
                print("Player Loses")
                if score > 0 {
                    score -= 1
                }
            }
            
        } else if gameChoice == false {
            if moves[gamesMove] == loseMoves[number] {
                score += 1
                print("Player Wins")
            } else {
                print("Player Loses")
                if score > 0 {
                    score -= 1
                }
            }
        }
        addTurn()
        showChoice = true
    }
    
    func addTurn() {
        turns += 1
        if turns == 11 {
            reset = true
        }
        
    }
    
    func newTurn() {
        gamesMove = Int.random(in: 0...2)
        gameChoice.toggle()
    }
    
    func resetGame() {
        newTurn()
        turns = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

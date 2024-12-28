//
//  BoardViewController.swift
//  TicTacToe
//
//  Created by Diggo Silva on 27/12/24.
//

import UIKit

class BoardViewController: UIViewController {
    
    let boardView = BoardView()
    
    override func loadView() {
        super.loadView()
        view = boardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegatesAndDataSources()
    }
    
    private func setNavBar() {
        title = "Jogo da velha"
    }
    
    private func setDelegatesAndDataSources() {
        boardView.delegate = self
    }
}

extension BoardViewController: BoardViewDelegate {
    func buttonTapped(_ sender: UIButton) {
        boardView.emptySpace -= 1
        boardView.labelTurn.text = boardView.isXTurn ? "É a vez de ⭕" : "É a vez de ❌"
        sender.setTitle(boardView.isXTurn ? "❌" : "⭕", for: .normal)
        sender.isEnabled = false
        boardView.isXTurn.toggle()
        boardView.checkWinner(sender)
    }
    
    func checkWinner(_ sender: UIButton) {
        if boardView.buttonA1.currentTitle == sender.currentTitle && boardView.buttonA2.currentTitle == sender.currentTitle && boardView.buttonA3.currentTitle == sender.currentTitle ||
           boardView.buttonB1.currentTitle == sender.currentTitle && boardView.buttonB2.currentTitle == sender.currentTitle && boardView.buttonB3.currentTitle == sender.currentTitle ||
           boardView.buttonC1.currentTitle == sender.currentTitle && boardView.buttonC2.currentTitle == sender.currentTitle && boardView.buttonC3.currentTitle == sender.currentTitle  {
               boardView.buttons.forEach({ $0.isEnabled = false })
               print("DEBUG: HORIZONTAL WIN")
        }
        else if boardView.buttonA1.currentTitle == sender.currentTitle && boardView.buttonB1.currentTitle == sender.currentTitle && boardView.buttonC1.currentTitle == sender.currentTitle ||
                boardView.buttonA2.currentTitle == sender.currentTitle && boardView.buttonB2.currentTitle == sender.currentTitle && boardView.buttonC2.currentTitle == sender.currentTitle ||
                boardView.buttonA3.currentTitle == sender.currentTitle && boardView.buttonB3.currentTitle == sender.currentTitle && boardView.buttonC3.currentTitle == sender.currentTitle  {
            boardView.buttons.forEach({ $0.isEnabled = false })
            print("DEBUG: VERTICAL WIN")
        }
        else if boardView.buttonA1.currentTitle == sender.currentTitle && boardView.buttonB2.currentTitle == sender.currentTitle && boardView.buttonC3.currentTitle == sender.currentTitle ||
                boardView.buttonA3.currentTitle == sender.currentTitle && boardView.buttonB2.currentTitle == sender.currentTitle && boardView.buttonC1.currentTitle == sender.currentTitle {
            boardView.buttons.forEach({ $0.isEnabled = false })
            print("DEBUG: DIAGONAL WIN")
        } else if boardView.emptySpace == 0 {
            print("DEBUG: EMPATE")
        }
    }
    
    func resetGame() {
        boardView.buttons.forEach({ $0.setTitle("", for: .normal) })
        boardView.buttons.forEach({ $0.isEnabled = true })
        boardView.emptySpace = 9
    }
}

//
//  BoardViewController.swift
//  TicTacToe
//
//  Created by Diggo Silva on 27/12/24.
//

import UIKit

class BoardViewController: UIViewController {
    
    var boardView = BoardView()
    
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
            alert(title: "Vitória de \(sender.currentTitle ?? "")", message: "Jogar novamente?")
        }
        else if boardView.buttonA1.currentTitle == sender.currentTitle && boardView.buttonB1.currentTitle == sender.currentTitle && boardView.buttonC1.currentTitle == sender.currentTitle ||
                boardView.buttonA2.currentTitle == sender.currentTitle && boardView.buttonB2.currentTitle == sender.currentTitle && boardView.buttonC2.currentTitle == sender.currentTitle ||
                boardView.buttonA3.currentTitle == sender.currentTitle && boardView.buttonB3.currentTitle == sender.currentTitle && boardView.buttonC3.currentTitle == sender.currentTitle  {
            boardView.buttons.forEach({ $0.isEnabled = false })
            alert(title: "Vitória de \(sender.currentTitle ?? "")", message: "Jogar novamente?")
        }
        else if boardView.buttonA1.currentTitle == sender.currentTitle && boardView.buttonB2.currentTitle == sender.currentTitle && boardView.buttonC3.currentTitle == sender.currentTitle ||
                boardView.buttonA3.currentTitle == sender.currentTitle && boardView.buttonB2.currentTitle == sender.currentTitle && boardView.buttonC1.currentTitle == sender.currentTitle {
            boardView.buttons.forEach({ $0.isEnabled = false })
            alert(title: "Vitória de \(sender.currentTitle ?? "")", message: "Jogar novamente?")
        } else if boardView.emptySpace == 0 {
            alert(title: "Empate", message: "Jogar novamente?")
        }
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let resetAction = UIAlertAction(title: "Sim", style: .default) { action in
            self.resetGame()
        }
        
        let gameOverAction = UIAlertAction(title: "Não", style: .default) { action in
            self.gameOver()
        }
        alert.addAction(resetAction)
        alert.addAction(gameOverAction)
        present(alert, animated: true)
    }
    
    func resetGame() {
        UIView.animate(withDuration: 0.25) {
            self.boardView.vStackView.alpha = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.boardView.buttons.forEach({ $0.setTitle("", for: .normal) })
            self.boardView.buttons.forEach({ $0.isEnabled = true })
            self.boardView.buttons.forEach({ $0.alpha = 1.0 })
            self.boardView.vStackView.alpha = 1.0
            self.boardView.emptySpace = 9
        }
    }
    
    func gameOver() {
        UIView.animate(withDuration: 0.25) {
            self.boardView.vStackView.alpha = 0.0
            self.boardView.gameOverLabel.alpha = 1.0
            self.boardView.labelTurn.alpha = 0.0
        }
    }
}

//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Diggo Silva on 31/12/24.
//

import XCTest
@testable import TicTacToe

final class TicTacToeTests: XCTestCase {
    
    var sut: BoardViewController!
    var mockButton: UIButton!
    
    override func setUp() {
        super.setUp()
        sut = BoardViewController()
        
        sut.boardView = BoardView()
        sut.boardView.isXTurn = false
        sut.boardView.emptySpace = 9
        
        mockButton = UIButton()
        mockButton.setTitle("❌", for: .normal)
        
        sut.loadViewIfNeeded()
    }
    
    func testButtonTappedChangesTitleAndDisablesButton() {
        XCTAssertEqual(mockButton.currentTitle, "❌")
        XCTAssertTrue(mockButton.isEnabled)
        
        sut.buttonTapped(mockButton)
        
        XCTAssertEqual(mockButton.currentTitle, "⭕")
        XCTAssertFalse(mockButton.isEnabled)
    }
    
    func testHorizontalWin() {
        sut.boardView.buttonA1.setTitle("❌", for: .normal)
        sut.boardView.buttonA2.setTitle("❌", for: .normal)
        sut.boardView.buttonA3.setTitle("❌", for: .normal)
        sut.checkWinner(mockButton)
        XCTAssertFalse(sut.boardView.buttons.allSatisfy({ $0.isEnabled }))
    }
    
    func testVerticalWin() {
        sut.boardView.buttonA1.setTitle("❌", for: .normal)
        sut.boardView.buttonB2.setTitle("❌", for: .normal)
        sut.boardView.buttonC3.setTitle("❌", for: .normal)
        sut.checkWinner(mockButton)
        XCTAssertFalse(sut.boardView.buttons.allSatisfy({ $0.isEnabled }))
    }
    
    func testDiagonalWin() {
        sut.boardView.buttonA3.setTitle("❌", for: .normal)
        sut.boardView.buttonB2.setTitle("❌", for: .normal)
        sut.boardView.buttonC1.setTitle("❌", for: .normal)
        sut.checkWinner(mockButton)
        XCTAssertFalse(sut.boardView.buttons.allSatisfy({ $0.isEnabled }))
    }
    
    func testDraw() {
        sut.boardView.buttonA1.setTitle("❌", for: .normal)
        sut.boardView.buttonA2.setTitle("⭕", for: .normal)
        sut.boardView.buttonA3.setTitle("❌", for: .normal)
        sut.boardView.buttonB1.setTitle("⭕", for: .normal)
        sut.boardView.buttonB2.setTitle("❌", for: .normal)
        sut.boardView.buttonB3.setTitle("⭕", for: .normal)
        sut.boardView.buttonC1.setTitle("⭕", for: .normal)
        sut.boardView.buttonC2.setTitle("❌", for: .normal)
        sut.boardView.buttonC3.setTitle("⭕", for: .normal)
        sut.boardView.emptySpace = 0
        let result = 0
        sut.checkWinner(mockButton)
        XCTAssertEqual(result, sut.boardView.emptySpace)
    }
    
    func testResetGame() {
        sut.resetGame()
        XCTAssertTrue(sut.boardView.buttons.allSatisfy({ $0.isEnabled }))
        XCTAssertEqual(sut.boardView.emptySpace, 9)
        XCTAssertTrue(sut.boardView.buttons.contains(where: { $0.currentTitle == "" }))
    }
    
    func testGameOver() {
        XCTAssertEqual(sut.boardView.gameOverLabel.alpha, 0.0)
        sut.gameOver()
        XCTAssertEqual(sut.boardView.gameOverLabel.alpha, 1.0)
    }
    
    override func tearDown() {
        sut = nil
        mockButton = nil
        super.tearDown()
    }
}

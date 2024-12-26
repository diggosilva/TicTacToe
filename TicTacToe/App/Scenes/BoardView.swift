//
//  BoardView.swift
//  TicTacToe
//
//  Created by Diggo Silva on 23/12/24.
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
        
    }
}

protocol BoardViewDelegate: AnyObject {
    func buttonTapped(_ sender: UIButton)
    func checkWinner(_ sender: UIButton)
    func resetGame()
}

class BoardView: UIView {
    lazy var labelTurn: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
        return lbl
    }()
    
    lazy var buttonA1: UIButton = buildButton(tag: 0)
    lazy var buttonA2: UIButton = buildButton(tag: 1)
    lazy var buttonA3: UIButton = buildButton(tag: 2)
    lazy var hStackViewA: UIStackView = buildStackView(arrangedSubviews: [buttonA1, buttonA2, buttonA3])
    
    lazy var buttonB1: UIButton = buildButton(tag: 3)
    lazy var buttonB2: UIButton = buildButton(tag: 4)
    lazy var buttonB3: UIButton = buildButton(tag: 5)
    lazy var hStackViewB: UIStackView = buildStackView(arrangedSubviews: [buttonB1, buttonB2, buttonB3])
    
    lazy var buttonC1: UIButton = buildButton(tag: 6)
    lazy var buttonC2: UIButton = buildButton(tag: 7)
    lazy var buttonC3: UIButton = buildButton(tag: 8)
    lazy var hStackViewC: UIStackView = buildStackView(arrangedSubviews: [buttonC1, buttonC2, buttonC3])
    
    lazy var vStackView: UIStackView = buildStackView(arrangedSubviews: [hStackViewA, hStackViewB, hStackViewC], axis: .vertical)
    
    lazy var resetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Reset Game", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        btn.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        return btn
    }()
    
    lazy var buttons: [UIButton] = [buttonA1, buttonA2, buttonA3, buttonB1, buttonB2, buttonB3, buttonC1, buttonC2, buttonC3]
    
    weak var delegate: BoardViewDelegate?
    var isXTurn: Bool = true
    var emptySpace: Int = 9
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        labelTurn.text = "É a vez de ❌"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        emptySpace -= 1
        labelTurn.text = isXTurn ? "É a vez de ⭕" : "É a vez de ❌"
        sender.setTitle(isXTurn ? "❌" : "⭕", for: .normal)
        sender.isEnabled = false
        isXTurn.toggle()
        checkWinner(sender)
//        delegate?.buttonTapped(sender)
    }
    
    func checkWinner(_ sender: UIButton) {
        if buttonA1.currentTitle == sender.currentTitle && buttonA2.currentTitle == sender.currentTitle && buttonA3.currentTitle == sender.currentTitle ||
           buttonB1.currentTitle == sender.currentTitle && buttonB2.currentTitle == sender.currentTitle && buttonB3.currentTitle == sender.currentTitle ||
           buttonC1.currentTitle == sender.currentTitle && buttonC2.currentTitle == sender.currentTitle && buttonC3.currentTitle == sender.currentTitle  {
               buttons.forEach({ $0.isEnabled = false })
               print("DEBUG: HORIZONTAL WIN")
        }
        else if buttonA1.currentTitle == sender.currentTitle && buttonB1.currentTitle == sender.currentTitle && buttonC1.currentTitle == sender.currentTitle ||
                buttonA2.currentTitle == sender.currentTitle && buttonB2.currentTitle == sender.currentTitle && buttonC2.currentTitle == sender.currentTitle ||
                buttonA3.currentTitle == sender.currentTitle && buttonB3.currentTitle == sender.currentTitle && buttonC3.currentTitle == sender.currentTitle  {
            buttons.forEach({ $0.isEnabled = false })
            print("DEBUG: VERTICAL WIN")
        }
        else if buttonA1.currentTitle == sender.currentTitle && buttonB2.currentTitle == sender.currentTitle && buttonC3.currentTitle == sender.currentTitle ||
                buttonA3.currentTitle == sender.currentTitle && buttonB2.currentTitle == sender.currentTitle && buttonC1.currentTitle == sender.currentTitle {
            buttons.forEach({ $0.isEnabled = false })
            print("DEBUG: DIAGONAL WIN")
        } else if emptySpace == 0 {
            print("DEBUG: EMPATE")
        }
//        delegate?.checkWinner(sender)
    }
    
    @objc private func resetGame() {
        buttons.forEach({ $0.setTitle("", for: .normal) })
        buttons.forEach({ $0.isEnabled = true })
        emptySpace = 9
//        delegate?.resetGame()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = .systemBackground
        addSubviews([labelTurn, vStackView, resetButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelTurn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            labelTurn.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            vStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            resetButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            resetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func buildButton(title: String = "", tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 80)
        button.backgroundColor = .systemBackground
        button.setTitle(title, for: .normal)
        button.tag = tag
        button.addTarget(self, action: #selector (buttonTapped), for: .touchUpInside)
        return button
    }
    
    func buildStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .label
        return stackView
    }
}

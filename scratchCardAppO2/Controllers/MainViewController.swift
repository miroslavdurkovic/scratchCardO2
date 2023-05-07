//
//  ViewController.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 07/05/2023.
//

//MARK: - Imports
import Combine
import UIKit

//MARK: - Class
class MainViewController: UIViewController {
  //MARK: - Properties
  var scratchCardManager: ScratchCardManager = ScratchCardManager()
  private var subscriptions = Set<AnyCancellable>()

  //MARK: - Outlets
  @IBOutlet var codeLabel: UILabel!

  //MARK: - Lifecycle func
  override func viewDidLoad() {
    super.viewDidLoad()
    updateLabels(forStatus: scratchCardManager.scratchCard.statusText, code: scratchCardManager.scratchCard.code )
    subscribe()
  }

  //MARK: - Functions
  func updateLabels(forStatus statusText: String, code codeText: String) {
    navigationItem.title = statusText
    codeLabel.text = codeText.isEmpty ? "" : "Your code is: \n\(codeText)"
  }
  
  private func subscribe() {
    scratchCardManager.$scratchCard.sink { newCard in
      self.updateLabels(forStatus: newCard.statusText, code: newCard.code)
    }
    .store(in: &subscriptions)
  }
  
  //MARK: - Segue func
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let wipeCardViewController = segue.destination as? WipeCardViewController {
      wipeCardViewController.scratchCardManager = scratchCardManager
    } else if let activateCardViewController = segue.destination as? ActivateCardViewController {
      activateCardViewController.scratchCardManager = scratchCardManager
    } else {
      return
    }
  }
}


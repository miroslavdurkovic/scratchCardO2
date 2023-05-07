//
//  ActivateCardViewController.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 07/05/2023.
//

//MARK: - Imports
import UIKit

//MARK: - Class
class ActivateCardViewController: UIViewController {
  //MARK: - Properties
  var scratchCardManager: ScratchCardManager?
  
  //MARK: - Outlets
  @IBOutlet var statusLabel: UILabel!
  @IBOutlet var activateButton: UIButton!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!

  //MARK: - Actions
  @IBAction func activateCard() {
    activateButton.isEnabled = false
    activityIndicator.isHidden = false
    statusLabel.text = ""
    scratchCardManager?.activateCard({ status in
      DispatchQueue.main.async {
        self.activityIndicator.isHidden = true
        
        if (status == .active) {
          self.statusLabel.text = "Your card was activated succesfully."
          self.activateButton.titleLabel?.text = "Activated"
        } else {
          self.statusLabel.text = "You can activate card with button below"
          self.activateButton.isEnabled = true
        }
      }
    })
  }
  
  //MARK: - Lifecycle func
  override func viewDidLoad() {
    super.viewDidLoad()
    switch scratchCardManager?.scratchCard.status {
    case .new:
      statusLabel.text = "Your card wasn't wiped till now, please do it from main screen"
      activateButton.titleLabel?.text = "Activate"
    case .active:
      statusLabel.text = "Your card was activated already."
      activateButton.titleLabel?.text = "Activated"
    default:
      statusLabel.text = "You can activate card with button below"
      activateButton.isEnabled = true
    }
  }
}

//
//  WipeCardViewController.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 07/05/2023.
//

//MARK: - Imports
import UIKit

//MARK: - Class
class WipeCardViewController: UIViewController {
  //MARK: - Properties
  var scratchCardManager: ScratchCardManager?
  var cancelableWork: DispatchWorkItem?
  
  //MARK: - Outlets
  @IBOutlet var generatedUUIDLabel: UILabel!
  @IBOutlet var wipeOffButton: UIButton!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  
  //MARK: - Actions
  @IBAction func wipeOffCard() {
    wipeOffButton.isEnabled = false
    activityIndicator.isHidden = false
    generatedUUIDLabel.text = ""
    cancelableWork = DispatchWorkItem(block: {
      self.scratchCardManager?.wipeOff()
      self.generatedUUIDLabel.text = "Your code is: \n\(self.scratchCardManager?.scratchCard.code ?? "")"
      self.wipeOffButton.titleLabel?.text = "Wiped"
      self.activityIndicator.isHidden = true
    })
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: cancelableWork!)
  }
  
  //MARK: - Lifecycle func
  override func viewDidLoad() {
    super.viewDidLoad()
    
    switch scratchCardManager?.scratchCard.status {
    case .wiped:
      generatedUUIDLabel.text = "Your card was wiped already.\nYour code is: \n\(self.scratchCardManager?.scratchCard.code ?? "")"
      wipeOffButton.titleLabel?.text = "Wiped"
    case .active:
      generatedUUIDLabel.text = "Your card was activated, no other actions are available"
      wipeOffButton.titleLabel?.text = "Activated"
    default:
      generatedUUIDLabel.text = "You can wipe off card with button below"
      wipeOffButton.isEnabled = true
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    guard let work = cancelableWork else { return }
    work.cancel()
  }
}

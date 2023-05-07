//
//  ScratchCard.swift
//  scratchCardAppO2
//
//  Created by Miroslav Durkovic on 07/05/2023.
//

//MARK: - Imports
import Foundation

//MARK: - Enums
enum ScratchCardStatus {
  case new      // Default state
  case wiped    // state repesent wiped card
  case active   // final state when card is activated
}

//MARK: - Struct
struct ScratchCard {
  //MARK: - Properties
  var status: ScratchCardStatus = .new  //Set default status to new
  var code: String = ""
  
  //MARK: - Computed Properties
  var statusText: String {
    switch status {
    case .new:
      return "New card"
    case .wiped:
      return "Card wiped"
    case .active:
      return "Card activated"
    }
  }
}

//
//  StoryboardSupport.swift
//  locationv2
//
//  Created by Samantha 2 on 8/29/20.
//  Copyright © 2020 Samantha 2. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
  static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
}

extension StoryboardIdentifiable where Self: UITableViewCell {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
}



extension UIViewController: StoryboardIdentifiable { }
extension UITableViewCell: StoryboardIdentifiable { }


extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.storyboardIdentifier, for: indexPath) as? T else {
      fatalError("Could not find table view cell with identifier \(T.storyboardIdentifier)")
    }
    return cell
  }
  
  func cellForRow<T: UITableViewCell>(at indexPath: IndexPath) -> T {
    guard let cell = cellForRow(at: indexPath) as? T else {
      fatalError("Could not get cell as type \(T.self)")
    }
    return cell
  }
}

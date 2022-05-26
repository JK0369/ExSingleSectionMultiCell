//
//  ViewController.swift
//  ExSingleSectionMultiCell
//
//  Created by Jake.K on 2022/05/26.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  private let tableView: UITableView = {
    let view = UITableView()
    view.allowsSelection = false
    view.backgroundColor = .clear
    view.separatorStyle = .none
    view.bounces = true
    view.showsVerticalScrollIndicator = true
    view.contentInset = .zero
    view.register(MyCell.self, forCellReuseIdentifier: "MyCell")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let disposeBag = DisposeBag()
  var items: [MyItem] = [
    .normal,
    .special(text: "버튼1"),
    .normal,
    .special(text: "버튼2"),
    .special(text: "버튼3"),
    .normal,
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.tableView)
    NSLayoutConstraint.activate([
      self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
    ])
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.items.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
    switch self.items[indexPath.item] {
    case .normal:
      cell.prepare(text: nil)
      return cell
    case let .special(text):
      cell.prepare(text: text)
      cell.buttonTapObservable
        .throttle(.microseconds(500), scheduler: MainScheduler.asyncInstance)
        .bind { print("tap button!") }
        .disposed(by: cell.disposeBag)
      return cell
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch self.items[indexPath.row] {
    case .normal:
      print("did tap normal cell")
    case .special:
      print("did tap normal special")
    }
  }
}

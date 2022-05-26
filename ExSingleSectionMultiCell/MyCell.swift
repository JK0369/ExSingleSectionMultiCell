//
//  MyCell.swift
//  ExSingleSectionMultiCell
//
//  Created by Jake.K on 2022/05/26.
//

import UIKit
import RxSwift

final class MyCell: UITableViewCell {
  private let myImageView: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "dog")
    image.isUserInteractionEnabled = false
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.text = "special 셀"
    label.font = .systemFont(ofSize: 24)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private let button: UIButton = {
    let button = UIButton()
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  var buttonTapObservable: Observable<Void> {
    self.button.rx.tap.asObservable()
  }
  var disposeBag = DisposeBag()
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(self.myImageView)
    self.contentView.addSubview(self.label)
    self.contentView.addSubview(self.button)
    
    NSLayoutConstraint.activate([
      self.myImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor),
      self.myImageView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor),
      self.myImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
      self.myImageView.widthAnchor.constraint(equalToConstant: 120),
      self.myImageView.heightAnchor.constraint(equalToConstant: 120)
    ])
    NSLayoutConstraint.activate([
      self.label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      self.label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
    ])
    NSLayoutConstraint.activate([
      self.button.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
      self.button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
    ])
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.disposeBag = DisposeBag()
    self.prepare(text: nil)
  }
  
  func prepare(text: String?) {
    self.button.isHidden = text == nil
    self.label.isHidden = text == nil
    print(self.label.isHidden)
    self.button.setTitle(text, for: .normal)
  }
}

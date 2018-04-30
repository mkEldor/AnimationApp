//
//  SecondViewController.swift
//  Animation-App
//
//  Created by Eldor Makkambaev on 01.05.2018.
//  Copyright © 2018 Eldor Makkambaev. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    let cellId = "cellId"
    
    var phones = [Phone]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Logout", style: .done, target: self, action: #selector(handleLogout))
        
        phones.append(Phone.init(name: "iPhone 7 plus", price: "350$"))
        phones.append(Phone.init(name: "Samsung Galaxy S8", price: "500$"))
        phones.append(Phone.init(name: "LG G4", price: "400$"))
        phones.append(Phone.init(name: "Nexus 6P", price: "700$"))
        phones.append(Phone.init(name: "HTC One M9", price: "500$"))
        
        tableView.register(MyCell.self, forCellReuseIdentifier: cellId)
        
    }
    @objc func handleLogout(){
        present(ViewController(), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MyCell
        
        let phone = phones[indexPath.row]
        cell.phone = phone
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(123)
        let cell = tableView.visibleCells[indexPath.row] as? MyCell
        if let cell = cell{
            cell.accessoryType = .none
            cell.infoView.isHidden = false
            cell.infoView.alpha = 1
            UIView.transition(with: cell.infoView, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: ({(_) in
            }))
            
        }
        
        
    }
    private var finishedLoadingInitialTableCells = false
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var lastInitialDisplayableCell = false
        if phones.count > 0 && !finishedLoadingInitialTableCells {
            if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
                lastInitialDisplayableCell = true
            }
        }
        
        if !finishedLoadingInitialTableCells {
            if lastInitialDisplayableCell {
                finishedLoadingInitialTableCells = true
            }
            cell.transform = CGAffineTransform(translationX: -1000, y: 0)
            cell.alpha = 0
            
            UIView.animate(withDuration: 1, delay: 0.2*Double(indexPath.row), options: [.curveLinear], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
}




class MyCell: UITableViewCell {
    
    var phone: Phone? {
        didSet{
            detailTextLabel?.text = phone?.price
            textLabel?.text = phone?.name
        }
    }
    
    let processorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Snapdragon 808"
        return label
    }()
    
    let camerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.text = "16MPX"
        return label
    }()
    
    lazy var hideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("hide", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleHide), for: .touchUpInside)
        return button
    }()
    
    let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    
    @objc func handleHide(){
        print(456)
        UIView.animate(withDuration: 0.3, animations: {
            self.infoView.alpha = 0
            self.infoView.transform = CGAffineTransform.init(translationX: 200, y: 0)
        }) { (_) in
            self.infoView.isHidden = true
            self.infoView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        }
        
        
        self.accessoryType = .detailButton
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "cellId")
        self.accessoryType = .detailButton
        setupViews()
    }
    private func setupViews(){
        textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 17)
        
        addSubview(infoView)
        infoView.addSubview(processorLabel)
        infoView.addSubview(camerLabel)
        infoView.addSubview(hideButton)
        infoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        infoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        processorLabel.topAnchor.constraint(equalTo: (self.textLabel?.topAnchor)!).isActive = true
        processorLabel.leadingAnchor.constraint(equalTo: (self.textLabel?.leadingAnchor)!).isActive = true
        //processorLabel.widthAnchor.constraint(equalTo: (self.textLabel?.widthAnchor)!).isActive = true
        //processorLabel.heightAnchor.constraint(equalTo: (self.textLabel?.heightAnchor)!).isActive = true
        
        camerLabel.topAnchor.constraint(equalTo: (self.detailTextLabel?.topAnchor)!).isActive = true
        camerLabel.leadingAnchor.constraint(equalTo: (self.detailTextLabel?.leadingAnchor)!).isActive = true
        //camerLabel.widthAnchor.constraint(equalTo: (self.detailTextLabel?.widthAnchor)!).isActive = true
        //camerLabel.heightAnchor.constraint(equalTo: (self.detailTextLabel?.heightAnchor)!).isActive = true
        
        hideButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        hideButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        hideButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        hideButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Phone{
    var name: String?
    var price: String?
}


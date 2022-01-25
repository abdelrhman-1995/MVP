//
//  ViewController.swift
//  MVP
//
//  Created by Abdelrhman Sultan on 25/01/2022.
//

import UIKit

class UsersVC: UIViewController , UITableViewDelegate , UITableViewDataSource , userPresenterDelegate {
    private let TV : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private let present = presenter()
    private var US = [users]() // users
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        view.addSubview(TV)
        TV.delegate = self
        TV.dataSource = self
        present.setViewDelegate(delegate: self)
        present.getUsers()
    }
    override func viewDidLayoutSubviews() {
        TV.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        US.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TV.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = US[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TV.deselectRow(at: indexPath, animated: true)
        present.cellTaped(user: US[indexPath.row])
    }
    func presentUser(users: [users]) {
        self.US = users
        DispatchQueue.main.async {
            self.TV.reloadData()
        }
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


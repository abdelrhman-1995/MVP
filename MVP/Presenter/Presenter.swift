//
//  Presenter.swift
//  MVP
//
//  Created by Abdelrhman Sultan on 25/01/2022.
//

import Foundation
import UIKit

protocol userPresenterDelegate : AnyObject {
    func presentUser (users: [users])
    func showAlert (title : String , message : String)
    
}

typealias presenterDelegate = userPresenterDelegate & UIViewController

class presenter {
    weak var delegate : userPresenterDelegate?
    public func setViewDelegate (delegate : userPresenterDelegate){
        self.delegate = delegate
    }
    public func getUsers () {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("there is an error in URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data , error == nil else {
                print(error?.localizedDescription  as Any)
                return
            }
            do {
                let users = try JSONDecoder().decode([users].self, from: data)
                self?.delegate?.presentUser(users : users)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    public func cellTaped (user : users){
        delegate?.showAlert(title: user.name, message: "\(user.username) email is: \n \(user.email)")
    }
}

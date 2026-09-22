//
//  ViewController.swift
//  AsyncAwaitAssignment
//
//  Created by Omsai Mutyalwar on 22/09/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Calling the task 1 implementation.
        testTask1()

        // Calling the task 2 implementation.
        Task {
            do {
                let users = try await UserService().fetchUsers()
                for user in users {
                    // / Stores the user in the map as per the assignment requirement.
                    usersByID[user.id] = user

                    // Printing the name and few other properties as per the assignment requirement.
                    print("Name: \(user.name)")
                    print("Username: \(user.username)")
                    print("Email: \(user.email)")
                    print("Phone: \(user.phone)")
                    print("Website: \(user.website)")
                    print("++++++++++++++++++++++++++++++++++++++++++++=")
                    print()
                }
            } catch let error as NetworkError {
                print(error.userMessage)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


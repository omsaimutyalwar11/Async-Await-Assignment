//
//  Task1.swift
//  AsyncAwaitAssignment
//
//  Created by Omsai Mutyalwar on 22/09/26.
//

/*
 1. Convert a completion handler to async/await
 You're given a callback-based greeting loader. Modernize it

 func loadGreeting(completion: @escaping (String) -> Void) {
 DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
 completion("Hello!")
 }
 }

 Your job:
 1. Write `func loadGreeting() async -> String a function that returns the greeting after the delay.
 2. Call it from a `Task {}` and print the result.
 */

import Foundation

func loadGreeting() async -> String {
    // Delay for 1 second.
    try? await Task.sleep(for: .seconds(1))
    return "Hello!"
}

func testTask1() {
    Task {
        let greeting = await loadGreeting()
        print(greeting)
    }
}

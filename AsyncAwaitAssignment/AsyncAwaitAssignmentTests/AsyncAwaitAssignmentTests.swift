//
//  AsyncAwaitAssignmentTests.swift
//  AsyncAwaitAssignmentTests
//
//  Created by Omsai Mutyalwar on 22/09/26.
//
/*
 Task 3 -
 3. Write tests for the above task 2 (fetching data from the network).

 You have to write tests for the fetch user task, one test for the success path and one for the failing
 path. Stub a failing async function and verify it throws.
 */

import Testing
@testable import AsyncAwaitAssignment

// Creating a stub for success path as per the assignment.
struct SuccessPathUserServiceStub: UserServiceProtocol {
    func fetchUsers() async throws -> [User] {
        return [
            User(
                id: 1,
                name: "Leanne Graham",
                username: "Bret",
                email: "Sincere@april.biz",
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                latitude: "-37.3159",
                longitude: "81.1496",
                phone: "1-770-736-8031 x56442",
                website: "hildegard.org",
                companyName: "Romaguera-Crona",
                catchPhrase: "Multi-layered client-server neural-net",
                companyDescription: "harness real-time e-markets"
            )
        ]
    }
}

// Creating a stub for failing path as per the assignment.
struct FailingPathUserServiceStub: UserServiceProtocol {
    func fetchUsers() async throws -> [User] {
        throw NetworkError.offline
    }
}

struct UserServiceTests {

    @Test
    func fetchUsersSuccessPath() async throws {
        let service: UserServiceProtocol = SuccessPathUserServiceStub()
        let users = try await service.fetchUsers()

        #expect(users.count == 1)
        #expect(users.first?.id == 1)
        #expect(users.first?.name == "Leanne Graham")
        #expect(users.first?.username == "Bret")
        #expect(users.first?.email == "Sincere@april.biz")
        #expect(users.first?.phone == "1-770-736-8031 x56442")
        #expect(users.first?.website == "hildegard.org")
        #expect(users.first?.street == "Kulas Light")
        #expect(users.first?.city == "Gwenborough")
        #expect(users.first?.latitude == "-37.3159")
        #expect(users.first?.longitude == "81.1496")
        #expect(users.first?.companyName == "Romaguera-Crona")
        #expect(users.first?.catchPhrase == "Multi-layered client-server neural-net")
        #expect(users.first?.companyDescription == "harness real-time e-markets")
    }

    @Test
    func fetchUsersFailurePath() async {
        let service: UserServiceProtocol = FailingPathUserServiceStub()

        await #expect(throws: NetworkError.offline) {
            try await service.fetchUsers()
        }
    }
}

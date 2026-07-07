import XCTest
@testable import Hikejot

@MainActor
final class HikejotTests: XCTestCase {
    func testSeedDataLoaded() {
        let store = Store()
        XCTAssertFalse(store.entries.isEmpty)
    }

    func testAddEntry() {
        let store = Store()
        let before = store.entries.count
        store.add(trail: "Ridge Loop", value1: 10, value2: 5)
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testAddRespectsFreeLimit() {
        let store = Store()
        store.entries = []
        for i in 0..<Store.freeLimit {
            store.add(trail: "Ridge Loop", value1: i, value2: 1)
        }
        let result = store.add(trail: "Ridge Loop", value1: 1, value2: 1)
        XCTAssertFalse(result)
        XCTAssertEqual(store.entries.count, Store.freeLimit)
    }

    func testProBypassesLimit() {
        let store = Store()
        store.entries = []
        store.isPro = true
        for i in 0..<(Store.freeLimit + 3) {
            store.add(trail: "Ridge Loop", value1: i, value2: 1)
        }
        XCTAssertEqual(store.entries.count, Store.freeLimit + 3)
    }

    func testDeleteEntry() {
        let store = Store()
        store.entries = []
        store.add(trail: "Ridge Loop", value1: 1, value2: 1)
        let entry = store.entries[0]
        store.delete(entry)
        XCTAssertTrue(store.entries.isEmpty)
    }

    func testDeleteAtOffsets() {
        let store = Store()
        store.entries = []
        store.add(trail: "Ridge Loop", value1: 1, value2: 1)
        store.add(trail: "Ridge Loop", value1: 2, value2: 2)
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.entries.count, 1)
    }

    func testUpdateEntry() {
        let store = Store()
        store.entries = []
        store.add(trail: "Ridge Loop", value1: 1, value2: 1)
        var entry = store.entries[0]
        entry.value1 = 99
        store.update(entry)
        XCTAssertEqual(store.entries[0].value1, 99)
    }

    func testCanAddMoreReflectsLimit() {
        let store = Store()
        store.entries = []
        XCTAssertTrue(store.canAddMore)
    }
}

//
//  BookReaderSystem.swift
//  BookReader
//
//  Created by Andrey Ermoshin on 07/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

struct Bookmark {
    let pageNumber: UInt
    let selectedText: String?
}

protocol Book {
    func open(on pageNumber: UInt)
    func open(on bookmark: Bookmark)
    func title() -> String
}

// should be stored for specific user account
// becaise each book could have, for example,
// different bookmarks for different users

struct BookContext: Hashable {
    var hashValue: Int
    
    static func ==(lhs: BookContext, rhs: BookContext) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let theBook: Book
    var lastReadPageNumber: UInt = 0
    var booksmarks = [Bookmark]()
    // structure of contents table is
    // H1 headlines which could contain H2 headlines and so on
    // https://developer.apple.com/library/content/documentation/CoreFoundation/Conceptual/CFCollections/Articles/usingtrees.html
    let contentsTableHeadNode: TreeNode<Bookmark>? = nil
    
    init(book: Book) {
        theBook = book
        hashValue = theBook.title().hashValue
    }
}

struct BookStoreAccount: Hashable {
    var hashValue: Int
    
    static func ==(lhs: BookStoreAccount, rhs: BookStoreAccount) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let username: String
    var boughtBooks = Set<BookContext>()
    
    init(_ nameOfTheUser: String) {
        username = nameOfTheUser
        hashValue = username.hashValue
    }
}

protocol BooksDatabase {
    func searchBooks(with textInTitle: String) -> [Book]?
    func add(book: Book)
    // removing of the book should lead to
    // notifying all users of that book
    // to probably clean their bookmarks
    // so, it could be solved by observing that type of change
    func remove(book: Book)
}

protocol BookStorePublicInterface {
    func registerUser(with accountName: String) throws -> BookStoreAccount
    func login(with accountName: String, password: String) throws -> BookStoreAccount
    // only registered users can search
    func searchBooks(with title: String, account: BookStoreAccount) -> [BookContext]?
}

class OnlineBookStore: BookStorePublicInterface {
    func searchBooks(with title: String, account: BookStoreAccount) -> [BookContext]? {
        // TODO: implement
        return nil
    }
    
    func login(with accountName: String, password: String) throws -> BookStoreAccount {
        // TODO: implement search for account using password hash
        return BookStoreAccount("userId1")
    }
    
    func registerUser(with accountName: String) throws -> BookStoreAccount {
        // TODO: implement check for already exist accounts with
        // requested account name and raise an exception if it has already
        // occupied by another person
        return BookStoreAccount("userId1")
    }
    
    // use of set to allow fast lookup by using exact book name?
    let booksDb: BooksDatabase
    // username - Key and structure for book as a payload
    var accounts = Dictionary<String, BookStoreAccount>()
    
    init(database: BooksDatabase) {
        booksDb = database
    }
}

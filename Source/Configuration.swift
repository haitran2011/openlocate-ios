//
//  Configuration.swift
//
//  Copyright (c) 2017 OpenLocate
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public typealias Headers = [String: String]

// Configuration

public protocol Configuration {
    var url: String { get }
    var headers: Headers? { get }
    var valid: Bool { get }
}

extension Configuration {
    public var valid: Bool {
        return !url.isEmpty
    }
}

// SafeGraph Configuration

private let baseUrl = "https://api.safegraph.com/v1"

public struct SafeGraphConfiguration {
    public let uuid: UUID
    public let token: String

    public init(uuid: UUID, token: String) {
        self.uuid = uuid
        self.token = token
    }
}

extension SafeGraphConfiguration: Configuration {
    public var url: String {
        return "\(baseUrl)/provider/\(uuid.uuidString.lowercased())/devicelocation"
    }

    public var headers: Headers? {
        if token.isEmpty {
            return nil
        }

        return ["Authorization": "Bearer \(token)"]
    }

    public var valid: Bool {
        return headers != nil
    }
}
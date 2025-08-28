import Foundation

public enum APIError: Error {
    case networkNotConnect
    case statusCode(Int)
    case decodingFailed
    case undefined
}

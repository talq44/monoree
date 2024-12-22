import Foundation

extension Error {
    public var apiError: RestAPIError {
        do {
            throw self
        } catch DecodingError.dataCorrupted(_) {
            return .serializationFailed
        } catch DecodingError.keyNotFound(_, _) {
            return .serializationFailed
        } catch DecodingError.valueNotFound(_, _) {
            return .serializationFailed
        } catch DecodingError.typeMismatch(_, _)  {
            return .serializationFailed
        } catch {
            return .unDefined
        }
    }
}

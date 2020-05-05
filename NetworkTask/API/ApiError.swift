import Foundation

enum ApiError : Error {
    case MissingURL
    case MissingAuthToken
    case WrongHttpMethod
    case BadRequest
    case MissingParameter
    case InternalServerError
    case InvalidToken
    case UserNotFound
    case WrongEventId
}

extension ApiError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .MissingURL:
            return NSLocalizedString("Missing URL parameter.", comment: "")
        case .MissingAuthToken:
            return NSLocalizedString("Missing Authorization token in request.", comment: "")
        case .WrongHttpMethod:
            return NSLocalizedString("Wrong HTTP method.", comment: "")
        case .BadRequest:
            return NSLocalizedString("Bad HTTP request.", comment: "")
        case .MissingParameter:
            return NSLocalizedString("Missing parameter.", comment: "")
        case .InternalServerError:
            return NSLocalizedString("Internal server error.", comment: "")
        case .InvalidToken:
            return NSLocalizedString("Invalid auth token.", comment: "")
        case .UserNotFound:
            return NSLocalizedString("User not found. Wrong authToken.", comment: "")
        case .WrongEventId:
            return NSLocalizedString("Wrong event id provieded.", comment: "")
        }
    }
}

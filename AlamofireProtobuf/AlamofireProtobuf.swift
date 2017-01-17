//
//
//

import Foundation
import Alamofire
import Protobuf

private let PROTOBUF_TYPE = "application/x-protobuf"

@discardableResult
public func request(
        _ url: URLConvertible,
        requestMessage: GPBMessage,
        headers: HTTPHeaders? = nil)
                -> DataRequest {
    return SessionManager.default.request(url, requestMessage: requestMessage)
}

extension SessionManager {

    @discardableResult
    open func request(
            _ url: URLConvertible,
            requestMessage: GPBMessage)
                    -> DataRequest
    {
        let headers = ["Accept":PROTOBUF_TYPE,
                       "Content-Type":PROTOBUF_TYPE]
        var originalRequest: URLRequest?
        originalRequest = try! URLRequest(url: url, method: .post, headers: headers)
        originalRequest!.httpBody = requestMessage.data()
        return request(originalRequest!)
    }
}

// MARK: - Protobuf

extension DataRequest {

    static var acceptableProtobufContentTypes: Set<String> = [
            PROTOBUF_TYPE
    ]

    public class func protobufResponseSerializer(
            responseMessageHandler: @escaping (Data?) throws -> GPBMessage)
                    -> DataResponseSerializer<GPBMessage>
    {
        return DataResponseSerializer { request, response, data, error in
            let result = serializeResponseData(response: response, data: data, error: error)

            guard case let .success(data) = result else { return .failure(result.error!) }

            do {
                try DataRequest.validateContentType(for: request, response: response)
                let responseMessage: GPBMessage = try responseMessageHandler(data)
                return .success(responseMessage)
            } catch {
                return .failure(error)
            }
        }
    }

    @discardableResult
    public func responseProtobuf(
            responseMessageHandler: @escaping (Data?) throws -> GPBMessage,
            completionHandler: @escaping (DataResponse<GPBMessage>) -> Void)
                    -> Self
    {
        return response(
                responseSerializer: DataRequest.protobufResponseSerializer(responseMessageHandler: responseMessageHandler),
                completionHandler: completionHandler
        )
    }

    public class func validateContentType(for request: URLRequest?, response: HTTPURLResponse?) throws {
        if let url = request?.url, url.isFileURL { return }

        guard let mimeType = response?.mimeType else {
            let contentTypes = Array(DataRequest.acceptableProtobufContentTypes)
            throw AFError.responseValidationFailed(reason: .missingContentType(acceptableContentTypes: contentTypes))
        }

        guard DataRequest.acceptableProtobufContentTypes.contains(mimeType) else {
            let contentTypes = Array(DataRequest.acceptableProtobufContentTypes)

            throw AFError.responseValidationFailed(
                    reason: .unacceptableContentType(acceptableContentTypes: contentTypes, responseContentType: mimeType)
            )
        }
    }
}
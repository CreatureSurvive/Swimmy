//
//  Publisher.swift
//  
//
//  Created by Dana Buehre on 11/9/23.
//

#if canImport(Combine)
import Combine
#elseif canImport(CombineX)
import CombineX
#endif

#if canImport(Combine) || canImport(CombineX)
public extension Publisher {
    /**
     Creates a new publisher which will upon failure retry the upstream publisher a provided number of times, with the provided delay between retry attempts.
     If the upstream publisher succeeds the first time this is bypassed and proceeds as normal.

     - Parameters:
        - retries: The number of times to retry the upstream publisher.
        - delay: Delay in seconds between retry attempts.
        - scheduler: The scheduler to dispatch the delayed events.

     - Returns: A new publisher which will retry the upstream publisher with a delay upon failure.

     let url = URL(string: "https://api.myService.com")!

     URLSession.shared.dataTaskPublisher(for: url)
         .retryWithDelay(retries: 4, delay: 5, scheduler: DispatchQueue.global())
         .sink { completion in
             switch completion {
             case .finished:
                 print("Success 😊")
             case .failure(let error):
                 print("The last and final failure after retry attempts: \(error)")
             }
         } receiveValue: { output in
             print("Received value: \(output)")
         }
         .store(in: &cancellables)
     */
    func retryWithDelay<S>(
        retries: Int,
        delay: S.SchedulerTimeType.Stride,
        scheduler: S
    ) -> AnyPublisher<Output, Failure> where S: Scheduler {
        delayIfFailure(for: delay, scheduler: scheduler) { error in
            if let error = error as? LemmyAPIError {
                switch error {
                case .lemmyError(message: _, code: let code), .network(code: let code, description: _):
                    debugPrint(error)
                    return !(code <= 0 || (code >= 400 && code < 500))
                default:
                    return true
                }
            }
            return true
        }
        .retry(times: retries) { error in
            if let error = error as? LemmyAPIError {
                switch error {
                case .lemmyError(message: _, code: let code), .network(code: let code, description: _):
                    return !(code <= 0 || (code >= 400 && code < 500))
                default:
                    return true
                }
            }
            return true
        }
        .eraseToAnyPublisher()
    }

    private func delayIfFailure<S>(
        for delay: S.SchedulerTimeType.Stride,
        scheduler: S,
        condition: @escaping (Error) -> Bool
    ) -> AnyPublisher<Output, Failure> where S: Scheduler {
        return self.catch { error in
            Future { completion in
                scheduler.schedule(after: scheduler.now.advanced(by: condition(error) ? delay : 0)) {
                    completion(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    internal func retry(times: Int, if condition: @escaping (Failure) -> Bool) -> Publishers.RetryIf<Self> {
        Publishers.RetryIf(publisher: self, times: times, condition: condition)
    }
}

extension Publishers {
    struct RetryIf<P: Publisher>: Publisher {
        typealias Output = P.Output
        typealias Failure = P.Failure
        
        let publisher: P
        let times: Int
        let condition: (P.Failure) -> Bool
                
        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            guard times > 0 else { return publisher.receive(subscriber: subscriber) }
            
            publisher.catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
                if condition(error) {
                    return RetryIf(publisher: publisher, times: times - 1, condition: condition).eraseToAnyPublisher()
                } else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }
            .receive(subscriber: subscriber)
        }
    }
}
#endif

//
//  CallCenterSystem.swift
//  CallCenter
//
//  Created by admin on 24/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

protocol Employee: class {
    var busyWithCall: Bool {get set}
}

// Reference type to have only one boolean state
// for all references of one object

class Respondent: Employee {
    var busyWithCall: Bool = false
}

class Manager: Employee {
    var busyWithCall: Bool = false
}

class Director: Employee {
    var busyWithCall: Bool = false
}

protocol Call: class {
    associatedtype T
    associatedtype Person
    var callEndedHandler: ((Person, T) -> Void)? {get set}
    var identifier: T {get}
    var answerer: Person? {get set}
}

class IncomingCall: Call {
    
    typealias T = UInt
    typealias Person = Employee
    var identifier: UInt
    var callEndedHandler: ((Employee, UInt) -> Void)?
    var answerer: Employee?
    
    // for debug
    var timer: DispatchSource?
    
    init(identity: UInt) {
        identifier = identity
    }
    
    func answer() {
        let seconds = Double(arc4random_uniform(10) + 1);
        print(#function + ": call \(identifier) answered")
        DispatchQueue.global().asyncAfter(deadline: .now() + seconds) { [weak self] in
            guard let strongSelf = self else { return }
            if let endAction = strongSelf.callEndedHandler, let responder = strongSelf.answerer {
                endAction(responder, strongSelf.identifier)
            }
        }
    }
}

protocol CallCenter {
    func handleIncoming(call: IncomingCall) -> Void
}

class ConcreteCallCenter: CallCenter {
    var incomingCallsQueue = Queue<IncomingCall>()
    var onlineIncomingCalls = [IncomingCall]()
    var respondents = [Respondent]()
    var managers = [Manager]()
    let director: Director
    
    let handlingQueue = DispatchQueue(label: "handling")
    let answeredCallsQueue = DispatchQueue(label: "answeredCalls")
    
    init(callCenterHead: Director) {
        director = callCenterHead
    }
    
    func createCallEndHandler() -> (Employee,  UInt) -> Void {
        // probably it's better to have static function because it is created
        // many times and it is always the same
        return { [weak self] (employee, callId) in
            guard let strongSelf = self else { return }
            // Reference type also needed because of that below
            // because overwise eployee will be just let constant
            // and it would be impossible to change boolean
            
            print(#function + ": call \(callId) ended")
            employee.busyWithCall = false
            // search for next call from the queue to assing to freed employee
            strongSelf.answeredCallsQueue.sync { [weak self] in
                guard let strongSelf = self else {return}
                for (i, call) in strongSelf.onlineIncomingCalls.enumerated() {
                    if call.identifier == callId {
                        strongSelf.onlineIncomingCalls.remove(at: i)
                        break
                    }
                }
                
                if strongSelf.onlineIncomingCalls.count == 0 {
                    print("All calls were answered and handled")
                }
            }
            
            // handle next call because we know that one respondent is free now
            // NOTE: the call could be moved to the end of queue by mistake
            // in that case if we will not think about concurrency of selecting
            // responder
            if !strongSelf.incomingCallsQueue.isEmpty {
                strongSelf.handleIncoming(call: strongSelf.incomingCallsQueue.dequeue())
            }
        }
    }
    
    func findFreeAnswerer() -> Employee? {
        var freeAnswerer: Employee?
        let freeRespondents = respondents.filter({$0.busyWithCall == false})
        if freeRespondents.count == 0 {
            let freeManagers = managers.filter({$0.busyWithCall == false})
            if freeManagers.count == 0 {
                freeAnswerer = director.busyWithCall == false ? director : nil
            }
        }
        else {
            freeAnswerer = freeRespondents.first
        }
        return freeAnswerer
    }
    
    func handleIncoming(call: IncomingCall) {
        handlingQueue.async { [weak self] in
            guard let strongSelf = self else { return }
            
            if let answerer = strongSelf.findFreeAnswerer() {
                answerer.busyWithCall = true
                call.answerer = answerer
                call.callEndedHandler = strongSelf.createCallEndHandler()
                // need to run call and somehow retain it
                // but we can't use calls queue
                strongSelf.answeredCallsQueue.sync { [weak self] in
                    self?.onlineIncomingCalls.append(call)
                }
                call.answer()
            }
            else {
                strongSelf.incomingCallsQueue.enqueue(call)
            }
        }
    }
}


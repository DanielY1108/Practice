//
//  LoginViewModel.swift
//  BindingMVVM
//
//  Created by JINSEOK on 2023/02/13.
//

import Foundation

class Dynamic<T> {
    
    typealias Listner = (T) -> Void
    // 보면 타입만 지정해줌.
    var listner: Listner?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    // 이해가 어려울 수 있는데 순서를 보자면
    // 기본적으로 클로저는 이름이 없는 함수이다. 제너릭(모든 타입)인 callback으로 어떠한 ⭐️동작⭐️을 받아준다!
    // (bind함수는 작동할 동작을 정의하는 구간이라고 볼 수 있다.)
    // 일단 앱이 실행되면 bind는 메모리에 올라가 있는 상태이다! (listner의 동작을 준비만 함)
    // 그 후 value의 값이 변하게 되면 didset이 실행되면 listner는 bind에 정의된 동작을 갖고 동작을 하게 됩니다!
    func bind(callback: @escaping (T) -> Void) {
        self.listner = callback
    }
    
    init(_ value: T) {
        self.value = value
    }
}

struct LoginViewModel {
    var name = Dynamic("")
    var password = Dynamic("")
}

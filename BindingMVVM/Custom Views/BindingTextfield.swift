//
//  BindingTextfield.swift
//  BindingMVVM
//
//  Created by JINSEOK on 2023/02/13.
//

import UIKit

class BindingTextfield: UITextField {
            
    // 값이 변경 될 때마다 수행될 행동을 담고 있는 클로저 변수 생성
    // 이 행동을 하기위해 textFieldDidChange로 변할 때 마다 변경될 수 있도록 만들어 줘야 한다.
    var textChanged: (String) -> Void = { _ in }
    
    // 코드로 작성하려는 label, button, indicator, view 등등 사용 시
    // frame을 가진 모든 view 객체를 초기화 시켜 줘야함.
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // 스토리보드 또는 xib과 같은 작성된 객체를 가져 올 때
    // 코드로 작성한게 아니기 때문에 이를 컴파일러가 인식이 불가능하다.
    // 그래서 init(coder:)를 통해 코드로 변환 해주는 unarchiver 과정이 필요.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // 텍스트 필드가 생성되는 동시에 같이 작업을 수행 하고 싶다. (초기화시 실행되게 만듬)
    // 만약 텍스트 필드에 무언가를 입력할 때 마다 변경된 내용을 알고 싶다면 이와같이 만들 수 있다.
    private func commonInit() {
        // 텍스트 필드에 값이 변할 때 마다 동작 (editingChanged)
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    // 받고 싶은 클로저로 콜백을 만들어준다.
    // 변경된 값을 받아 바로 업데이트 시킬 수 있게 된다.
    func bind(callback: @escaping (String) -> Void) {
        
        self.textChanged = callback
        
    }
    
    // 이와 같이 만들어주면 변경된 텍스트르 받을 수 있다.
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let text = textField.text {
            textChanged(text)
        }
    }
}



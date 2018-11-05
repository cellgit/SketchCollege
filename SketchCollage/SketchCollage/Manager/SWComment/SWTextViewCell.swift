//
//  SWTextViewCell.swift
//  HouseRent
//
//  Created by liuhongli on 2018/11/1.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit

protocol SWEndEditDelegate {
    func sw_edit_result_action(text: String)
}

class SWTextViewCell: UITableViewCell {
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    var delegate: SWEndEditDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtView.delegate = self
        txtView.returnKeyType = .done //设置键盘类型
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SWTextViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.txtView.resignFirstResponder() // 回收键盘
        delegate.sw_edit_result_action(text: textView.text)
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" {
            self.placeholderLabel.text = ""
        }
        delegate.sw_edit_result_action(text: textView.text)
    }
    // 回收键盘: 点击键盘上的完成按钮
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension SWTextViewCell {
    /// 光标焦点触发的方法
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        placeholderLabel.text = ""
        if textView.text != "" {
            textView.text = self.txtView.text
        }
        return true
    }
}

extension SWTextViewCell:UITextFieldDelegate {
    func dismissView() {
        self.resignFirstResponder()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        textField.text = ""
        return true
    }
}


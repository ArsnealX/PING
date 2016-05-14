//
//  YTInputViewDelegate.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/15.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import Foundation

protocol YTInputViewDelegate:NSObjectProtocol{
    /**
     *  即将显示键盘时调用
     *
     *  @param inputView 当前输入框view
     *  @param height    键盘高度
     *  @param time      弹出时间
     */
     func inputViewWillShowKeyboardHeight(inputView:PTInputView,height:Float,time:NSNumber)->Void
    /**
     *  即将隐藏键盘时调用
     *
     *  @param inputView 当前输入框view
     *  @param time      弹出时间
     */
    func willHideKeyboardWithInputView(inputView:PTInputView,time:NSNumber)->Void
      /**
     *  点击return键时调用
     *
     *  @param inputView 当前输入框view
     *  @param text      输入的聊天内容(非空)
     */
    func inputViewWithText(inputView:PTInputView,text:String)->Void

}
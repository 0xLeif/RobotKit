//
//  Keyboard.swift
//  RobotKit
//
//  Created by Leif on 8/27/22.
//

import Carbon.HIToolbox.Events

/// Robot control of the keyboard
public struct RobotKeyboard: SelfTasking {
    /// Enum for Keys that map to CGKeyCodes
    public enum Key: CaseIterable {
        // MARK: - Characters
        case a
        case b
        case c
        case d
        case e
        case f
        case g
        case h
        case i
        case j
        case k
        case l
        case m
        case n
        case o
        case p
        case q
        case r
        case s
        case t
        case u
        case v
        case w
        case x
        case y
        case z
        
        // MARK: - Numbers
        case _0
        case _1
        case _2
        case _3
        case _4
        case _5
        case _6
        case _7
        case _8
        case _9
        
        // MARK: - Symbols
        case equal
        case minus
        case rightBracket
        case leftBracket
        case quote
        case semicolon
        case backslash
        case comma
        case slash
        case period
        case grave

        // MARK: - Keypad
        case keypadDecimal
        case keypadMultiply
        case keypadPlus
        case keypadClear
        case keypadDivide
        case keypadEnter
        case keypadMinus
        case keypadEquals
        case keypad0
        case keypad1
        case keypad2
        case keypad3
        case keypad4
        case keypad5
        case keypad6
        case keypad7
        case keypad8
        case keypad9
        
        // MARK: - Controls
        case Return
        case Tab
        case Space
        case Delete
        case Escape
        case Command
        case Shift
        case CapsLock
        case Option
        case Control
        case RightCommand
        case RightShift
        case RightOption
        case RightControl
        case Function
        case VolumeUp
        case VolumeDown
        case Mute
        case LeftArrow
        case RightArrow
        case DownArrow
        case UpArrow
        case PageDown
        case Help
        case Home
        case End
        case PageUp
        case ForwardDelete
        
        // MARK: - Functions
        case F17
        case F18
        case F19
        case F20
        case F5
        case F6
        case F7
        case F3
        case F8
        case F9
        case F11
        case F13
        case F16
        case F14
        case F10
        case F12
        case F15
        case F4
        case F2
        case F1
        
        /// CGKeyCode using `Carbon.HIToolbox.Events`
        public var code: CGKeyCode {
            switch self {
                // Leters
            case .a: return .init(kVK_ANSI_A)
            case .b: return .init(kVK_ANSI_B)
            case .c: return .init(kVK_ANSI_C)
            case .d: return .init(kVK_ANSI_D)
            case .e: return .init(kVK_ANSI_E)
            case .f: return .init(kVK_ANSI_F)
            case .g: return .init(kVK_ANSI_G)
            case .h: return .init(kVK_ANSI_H)
            case .i: return .init(kVK_ANSI_I)
            case .j: return .init(kVK_ANSI_J)
            case .k: return .init(kVK_ANSI_K)
            case .l: return .init(kVK_ANSI_L)
            case .m: return .init(kVK_ANSI_M)
            case .n: return .init(kVK_ANSI_N)
            case .o: return .init(kVK_ANSI_O)
            case .p: return .init(kVK_ANSI_P)
            case .q: return .init(kVK_ANSI_Q)
            case .r: return .init(kVK_ANSI_R)
            case .s: return .init(kVK_ANSI_S)
            case .t: return .init(kVK_ANSI_T)
            case .u: return .init(kVK_ANSI_U)
            case .v: return .init(kVK_ANSI_V)
            case .w: return .init(kVK_ANSI_W)
            case .x: return .init(kVK_ANSI_X)
            case .y: return .init(kVK_ANSI_Y)
            case .z: return .init(kVK_ANSI_Z)
                // Numbers
            case ._0: return .init(kVK_ANSI_0)
            case ._1: return .init(kVK_ANSI_1)
            case ._2: return .init(kVK_ANSI_2)
            case ._3: return .init(kVK_ANSI_3)
            case ._4: return .init(kVK_ANSI_4)
            case ._5: return .init(kVK_ANSI_5)
            case ._6: return .init(kVK_ANSI_6)
            case ._7: return .init(kVK_ANSI_7)
            case ._8: return .init(kVK_ANSI_8)
            case ._9: return .init(kVK_ANSI_9)
                // Symbols
            case .equal: return .init(kVK_ANSI_Equal)
            case .minus: return .init(kVK_ANSI_Minus)
            case .rightBracket: return .init(kVK_ANSI_RightBracket)
            case .leftBracket: return .init(kVK_ANSI_LeftBracket)
            case .quote: return .init(kVK_ANSI_Quote)
            case .semicolon: return .init(kVK_ANSI_Semicolon)
            case .backslash: return .init(kVK_ANSI_Backslash)
            case .comma: return .init(kVK_ANSI_Comma)
            case .slash: return .init(kVK_ANSI_Slash)
            case .period: return .init(kVK_ANSI_Period)
            case .grave: return .init(kVK_ANSI_Grave)
                // Keypad
            case .keypadDecimal: return .init(kVK_ANSI_KeypadDecimal)
            case .keypadMultiply: return .init(kVK_ANSI_KeypadMultiply)
            case .keypadPlus: return .init(kVK_ANSI_KeypadPlus)
            case .keypadClear: return .init(kVK_ANSI_KeypadClear)
            case .keypadDivide: return .init(kVK_ANSI_KeypadDivide)
            case .keypadEnter: return .init(kVK_ANSI_KeypadEnter)
            case .keypadMinus: return .init(kVK_ANSI_KeypadMinus)
            case .keypadEquals: return .init(kVK_ANSI_KeypadEquals)
            case .keypad0: return .init(kVK_ANSI_Keypad0)
            case .keypad1: return .init(kVK_ANSI_Keypad1)
            case .keypad2: return .init(kVK_ANSI_Keypad2)
            case .keypad3: return .init(kVK_ANSI_Keypad3)
            case .keypad4: return .init(kVK_ANSI_Keypad4)
            case .keypad5: return .init(kVK_ANSI_Keypad5)
            case .keypad6: return .init(kVK_ANSI_Keypad6)
            case .keypad7: return .init(kVK_ANSI_Keypad7)
            case .keypad8: return .init(kVK_ANSI_Keypad8)
            case .keypad9: return .init(kVK_ANSI_Keypad9)
                // Controls
            case .Return: return .init(kVK_Return)
            case .Tab: return .init(kVK_Tab)
            case .Space: return .init(kVK_Space)
            case .Delete: return .init(kVK_Delete)
            case .Escape: return .init(kVK_Escape)
            case .Command: return .init(kVK_Command)
            case .Shift: return .init(kVK_Shift)
            case .CapsLock: return .init(kVK_CapsLock)
            case .Option: return .init(kVK_Option)
            case .Control: return .init(kVK_Control)
            case .RightCommand: return .init(kVK_RightCommand)
            case .RightShift: return .init(kVK_RightShift)
            case .RightOption: return .init(kVK_RightOption)
            case .RightControl: return .init(kVK_RightControl)
            case .Function: return .init(kVK_Function)
            case .VolumeUp: return .init(kVK_VolumeUp)
            case .VolumeDown: return .init(kVK_VolumeDown)
            case .Mute: return .init(kVK_Mute)
            case .Help: return .init(kVK_Help)
            case .Home: return .init(kVK_Home)
            case .PageUp: return .init(kVK_PageUp)
            case .ForwardDelete: return .init(kVK_ForwardDelete)
            case .End: return .init(kVK_End)
            case .PageDown: return .init(kVK_PageDown)
            case .LeftArrow: return .init(kVK_LeftArrow)
            case .RightArrow: return .init(kVK_RightArrow)
            case .DownArrow: return .init(kVK_DownArrow)
            case .UpArrow: return .init(kVK_UpArrow)
                // Functions
            case .F17: return .init(kVK_F17)
            case .F18: return .init(kVK_F18)
            case .F19: return .init(kVK_F19)
            case .F20: return .init(kVK_F20)
            case .F5: return .init(kVK_F5)
            case .F6: return .init(kVK_F6)
            case .F7: return .init(kVK_F7)
            case .F3: return .init(kVK_F3)
            case .F8: return .init(kVK_F8)
            case .F9: return .init(kVK_F9)
            case .F11: return .init(kVK_F11)
            case .F13: return .init(kVK_F13)
            case .F16: return .init(kVK_F16)
            case .F14: return .init(kVK_F14)
            case .F10: return .init(kVK_F10)
            case .F12: return .init(kVK_F12)
            case .F15: return .init(kVK_F15)
            case .F4: return .init(kVK_F4)
            case .F2: return .init(kVK_F2)
            case .F1: return .init(kVK_F1)
            }
        }
    }
}

public extension RobotKeyboard {
    /// Type an array of Keys
    func type(keys: [Key]) {
        for key in keys {
            press(key)
            release(key)
        }
    }
    
    /// Type one or many Keys
    func type(_ keys: Key...) {
        type(keys: keys)
    }
    
    /// Type an array of Keys while holding shift
    func typeShifted(keys: [Key]) {
        press(.Shift)
        for key in keys {
            press(key)
            release(key)
        }
        release(.Shift)
    }
    
    /// Type one or many Keys while holding shift
    func typeShifted(_ keys: Key...) {
        typeShifted(keys: keys)
    }
    
    /// Press a key down until you call ``release(_:)``
    func press(_ key: Key) {
        usleep(10_000)
        CGEvent(
            keyboardEventSource: nil,
            virtualKey: key.code,
            keyDown: true
        )?.post(tap: .cghidEventTap)
    }
    
    /// Release the key from being pressed
    func release(_ key: Key) {
        CGEvent(
            keyboardEventSource: nil,
            virtualKey: key.code,
            keyDown: false
        )?.post(tap: .cghidEventTap)
        usleep(10_000)
    }
}

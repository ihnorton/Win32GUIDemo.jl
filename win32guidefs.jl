
typealias HANDLE Ptr{Void}
typealias HINSTANCE HANDLE
typealias HICON HANDLE
typealias HBRUSH HANDLE
typealias HCURSOR HICON
typealias HMENU HANDLE
typealias HDC HANDLE
typealias HMODULE HINSTANCE
# note: UNICODE is #def'd by libuv.
typealias LPCWSTR Ptr{Uint16}
typealias LPCTSTR LPCWSTR

typealias WNDPROC Ptr{Void}
typealias LRESULT Ptr{Void}
typealias LPVOID Ptr{Void}
typealias HWND HANDLE
typealias WPARAM Ptr{Cuint}
typealias LPARAM Ptr{Clong}
typealias ATOM Cushort
typealias WORD Cushort
typealias DWORD Culong
const CW_USEDEFAULT = 0x80000000

baremodule WinClassStyle
    const CS_BYTEALIGNCLIENT = 0x1000
    const CS_BYTEALIGNWINDOW = 0x2000
    const CS_CLASSDC = 0x0040
    const CS_DBLCLKS = 0x0008
    const CS_DROPSHADOW = 0x00020000
    const CS_GLOBALCLASS = 0x4000
    const CS_HREDRAW = 0x0002
    const CS_NOCLOSE = 0x0200
    const CS_OWNDC = 0x0020
    const CS_PARENTDC = 0x0080
    const CS_SAVEBITS = 0x0800
    const CS_VREDRAW = 0x0001
end
baremodule WinStyle
    import Base: (|), convert, Clong; L(x) = convert(Clong,x)
    
    const BORDER        = L(0x00800000)
    const CAPTION       = L(0x00C00000)
    const CHILD         = L(0x40000000)
    const CHILDWINDOW   = CHILD
    const CLIPCHILDREN  = L(0x02000000)
    const CLIPSIBLINGS  = L(0x04000000)
    const DISABLED      = L(0x08000000)
    const DLGFRAME      = L(0x00400000)
    const GROUP         = L(0x00020000)
    const HSCROLL       = L(0x00100000)
    const ICONIC        = L(0x20000000)
    const MAXIMIZE      = L(0x01000000)
    const MAXIMIZEBOX   = L(0x00010000)
    const MINIMIZE      = L(0x20000000)
    const MINIMIZEBOX   = L(0x00020000)
    const OVERLAPPED    = L(0x00000000)
    const POPUP         = L(0x80000000)
    const SIZEBOX       = L(0x00040000)
    const SYSMENU       = L(0x00080000)
    const TABSTOP       = L(0x00010000)
    const THICKFRAME    = L(0x00040000)
    const TILED         = L(0x00000000)
    const VISIBLE       = L(0x10000000)
    const VSCROLL       = L(0x00200000)
    
    const POPUPWINDOW       = L(POPUP | BORDER | SYSMENU)
    const TILEDWINDOW       = L(OVERLAPPED | CAPTION | SYSMENU | THICKFRAME |
                                 MINIMIZEBOX | MAXIMIZEBOX)
    const OVERLAPPEDWINDOW  = L(OVERLAPPED | CAPTION | SYSMENU | THICKFRAME |
                               MINIMIZEBOX | MAXIMIZEBOX)
end
baremodule WinExStyle
    import Base: (|), convert, Clong; L(x) = convert(Clong,x)

    const ACCEPTFILES   = L(0x00000010)
    const APPWINDOW     = L(0x00040000)
    const CLIENTEDGE    = L(0x00000200)
    const COMPOSITED    = L(0x02000000)
    const CONTEXTHELP   = L(0x00000400)
    const CONTROLPARENT = L(0x00010000)
    const DLGMODALFRAME = L(0x00000001)
    const LAYERED       = L(0x00080000)
    const LAYOUTRTL     = L(0x00400000)
    const LEFT          = L(0x00000000)
    const LEFTSCROLLBAR = L(0x00004000)
    const LTRREADING    = LEFT
    const MDICHILD      = L(0x00000040)
    const NOACTIVATE    = L(0x08000000)
    const NOINHERITLAYOUT=L(0x00100000)
    const NOPARENTNOTIFY= L(0x00000004)
    const NOREDIRECTOINBITMAP   = L(0x00200000)
    const RIGHT         = L(0x00001000)
    const RIGHTSCROLLBAR= L(0x00000000)
    const RTLREADING    = L(0x00002000)
    const STATICEDGE    = L(0x00020000)
    const TOOLWINDOW    = L(0x00000080)
    const TOPMOST       = L(0x00000008)
    const TRANSPARENT   = L(0x00000020)
    const WINDOWEDGE    = L(0x00000100)
    const OVERLAPPEDWINDOW      = L(WINDOWEDGE | CLIENTEDGE)
    const PALETTEWINDOW         = L(WINDOWEDGE | TOOLWINDOW |TOPMOST)
end # module WinExStyle

baremodule EditStyle
    import Base: (|), convert, Clong; L(x) = convert(Clong,x)
    
    const LEFT            = L(0x0000)
    const CENTER          = L(0x0001)
    const RIGHT           = L(0x0002)
    const MULTILINE       = L(0x0004)
    const UPPERCASE       = L(0x0008)
    const LOWERCASE       = L(0x0010)
    const PASSWORD        = L(0x0020)
    const AUTOVSCROLL     = L(0x0040)
    const AUTOHSCROLL     = L(0x0080)
    const NOHIDESEL       = L(0x0100)
    const OEMCONVERT      = L(0x0400)
    const READONLY        = L(0x0800)
    const WANTRETURN      = L(0x1000)
    const NUMBER          = L(0x2000)
end

Resource(id::Int) = convert(Ptr{Uint16}, id | 0xFFFF)

baremodule IDI
    import ..Resource
    const APPLICATION   = Resource(32512)
    const ASTERISK      = Resource(32516)
    const ERROR         = Resource(32513)
    const EXCLAMATION   = Resource(32515)
    const HAND          = Resource(32513)
    const INFORMATION   = Resource(32516)
    const QUESTION      = Resource(32514)
    const SHIELD        = Resource(32518)
    const WARNING       = Resource(32515)
    const WINLOGO       = Resource(32517)
end
baremodule IDC
    import ..Resource
    const ARROW = Resource(32650)
    # TODO
end
baremodule SysColor
    import Base.convert, ..HBRUSH
    const WINDOW = convert(HBRUSH,5)
    const WINDOWFRAME = convert(HBRUSH,6)
    const WINDOWTEXT = convert(HBRUSH,8)
end
baremodule MBICON
    import Base: convert, Clong; L(x) = convert(Clong,x)
    
    const EXCLAMATION   = L(0x00000030)
    const WARNING       = L(0x00000030)
    const INFORMATION   = L(0x00000040)
    const ASTERISK      = L(0x00000040)
    const QUESTION      = L(0x00000020)
    const STOP          = L(0x00000010)
    const ERROR         = STOP
    const HAND          = STOP
end 
baremodule SW
    const HIDE              = 0
    const SHOWNORMAL        = 1
    const SHOWMINIMIZE      = 2
    const MAXIMIZE          = 3
    const SHOWMAXIMIZE      = MAXIMIZE
    const SHOWNOACTIVATE    = 4
    const SHOW              = 5
    const MINIMIZE          = 6
    const SHOWMINNOACTIVE   = 7
    const SHOWNA            = 8
    const RESTORE           = 9
    const SHOWDEFAULT       = 10
    const FORCEMINIMIZE     = 11
end 
baremodule WA
    const     WA_INACTIVE     = 0
    const     WA_ACTIVE       = 1
    const     WA_CLICKACTIVE  = 2
end
   
baremodule WM
    const NULL                         = 0x0000
    const CREATE                       = 0x0001
    const DESTROY                      = 0x0002
    const MOVE                         = 0x0003
    const SIZE                         = 0x0005
    const ACTIVATE                     = 0x0006
    const SETFOCUS                     = 0x0007
    const KILLFOCUS                    = 0x0008
    const ENABLE                       = 0x000A
    const SETREDRAW                    = 0x000B
    const SETTEXT                      = 0x000C
    const GETTEXT                      = 0x000D
    const GETTEXTLENGTH                = 0x000E
    const PAINT                        = 0x000F
    const CLOSE                        = 0x0010

    const QUIT                         = 0x0012
    const ERASEBKGND                   = 0x0014
    const SYSCOLORCHANGE               = 0x0015
    const SHOWWINDOW                   = 0x0018
    const WININICHANGE                 = 0x001A
    const SETTINGCHANGE                = WININICHANGE
    const DEVMODECHANGE                = 0x001B
    const ACTIVATEAPP                  = 0x001C
    const FONTCHANGE                   = 0x001D
    const TIMECHANGE                   = 0x001E
    const CANCELMODE                   = 0x001F
    const SETCURSOR                    = 0x0020
    const MOUSEACTIVATE                = 0x0021
    const CHILDACTIVATE                = 0x0022
    const QUEUESYNC                    = 0x0023
    
    const INITDIALOG    = 0x0110
    const COMMAND       = 0x0111
    const SYSCOMMAND    = 0x0112
    const TIMER         = 0x0113
    const HSCROLL       = 0x0114
    const VSCROLL       = 0x0115
    const INITMENU      = 0x0116
    const INITMENUPOPUP = 0x0117
    # Windows 7
    #const GESTURE       = 0x0119
    #const GESTURENOTIFY = 0x011A
    #
    const MENUSELECT    = 0x011F
    const MENUCHAR      = 0x0120
    const ENTERIDLE     = 0x0121
    const MENUBUTTONUP  = 0x0122
    const MENUDRAG      = 0x0123
    const MENUGETOBJECT = 0x0124
    const UNINITMENUPOPUP = 0x0125
    const MENUCOMMAND   = 0x0126
    const CHANGEUISTATE = 0x0127
    const UPDATEUISTATE = 0x0128
    const QUERYUISTATE  = 0x0129
    
    const CTLCOLORMSGBOX    = 0x0132
    const CTLCOLOREDIT      = 0x0133
    const CTLCOLORLISTBOX   = 0x0134
    const CTLCOLORBTN       = 0x0135
    const CTLCOLORDLG       = 0x0136
    const CTLCOLORSCROLLBAR = 0x0137
    const CTLCOLORSTATIC    = 0x0138
    const MOUSEFIRST        = 0x0200
    const MOUSEMOVE         = 0x0200
    const LBUTTONDOWN       = 0x0201
    const LBUTTONUP         = 0x0202
    const LBUTTONDBLCLK     = 0x0203
    const RBUTTONDOWN       = 0x0204
    const RBUTTONUP         = 0x0205
    const RBUTTONDBLCLK     = 0x0206
    const MBUTTONDOWN       = 0x0207
    const MBUTTONUP         = 0x0208
    const MBUTTONDBLCLK     = 0x0209
    const MOUSEWHEEL        = 0x020A
    const XBUTTONDOWN       = 0x020B
    const XBUTTONUP         = 0x020C
    const XBUTTONDBLCLK     = 0x020D
    const WHEEL_DELTA       = 120
    # define GET_WHEEL_DELTA_WPARAM(wParam)  ((short)HIWORD(wParam))
    #define GET_KEYSTATE_WPARAM(wParam)     (LOWORD(wParam))
    #define GET_NCHITTEST_WPARAM(wParam)    ((short)LOWORD(wParam))
    #define GET_XBUTTON_WPARAM(wParam)      (HIWORD(wParam))
    const PARENTNOTIFY      = 0x0210
    const ENTERMENULOOP     = 0x0211
    const EXITMENULOOP      = 0x0212
    const NEXTMENU          = 0x0213
    const SIZING            = 0x0214
    const CAPTURECHANGED    = 0x0215
    const MOVING            = 0x0216
    
    #
    const SETBKGNDCOLOR     = 1091
end

# TODO
# const GETHMENU = 0x01E1
module Win32GUI

const _u32 = "User32.dll"
const _k32 = "Kernel32.dll"

typealias HANDLE Ptr{Void}
typealias HINSTANCE HANDLE
typealias HICON HANDLE
typealias HBRUSH HANDLE
typealias HCURSOR HICON
typealias HMENU HANDLE
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
    
LoadIcon(hInstance,lpIconName) = ccall((:LoadIconW, _u32),
                                        HICON,
                                        (HINSTANCE, LPCTSTR),
                                        hInstance,lpIconName)

immutable WNDCLASSEX
    cbSize::Cuint
    style::Cuint
    lpfnWndProc::WNDPROC
    cbClsExtra::Cint  
    cbWndExtra::Cint
    hInstance::HINSTANCE
    hIcon::HICON
    hCursor::HCURSOR
    hbrBackground::HBRUSH
    lpszMenuName::LPCTSTR
    lpszClassName::LPCTSTR
    hIconSm::HICON
  
    WNDCLASSEX(cbSize,style,lpfnWndProc,cbClsExtra,cbWndExtra,hInstance,
               hIcon,hCursor,hbrBackground,hpszMenuName,lpszClassName,
               hIconSm) =
            new(cbSize,style,lpfnWndProc,cbClsExtra,cbWndExtra,hInstance,
               hIcon,hCursor,hbrBackground,hpszMenuName,
               lpszClassName,hIconSm)
end

# WindowProc
# LRESULT CALLBACK WindowProc(HWND, UINT uMsg, WPARAM wParam, LPARAM lParam)

function WNDCLASSEX(
    className, wndProc, hInstance;
    style = 0,
    icon = LoadIcon(C_NULL, IDI.APPLICATION),
    cursor = LoadIcon(C_NULL, IDC.ARROW),
    background = SysColor.WINDOW,
    menuName = "",
    iconSmall = LoadIcon(C_NULL, IDI.APPLICATION),
    clsExtra = 0,
    wndExtra = 0,)
    if (menuName == "")
        hMenuName = C_NULL
    else
        hMenuName = pointer(utf16(menuName))
    end
    if (className == "")
        error("className cannot be empty")
    end
    WNDCLASSEX(sizeof(WNDCLASSEX),style,wndProc,clsExtra,wndExtra,hInstance,
               icon,cursor,background,hMenuName,pointer(utf16(className)),
               iconSmall)
    
end
   
function RegisterClass(class::Ptr{WNDCLASSEX})
    r = ccall((:RegisterClassExW, _u32), ATOM, (HANDLE,), class)
    (r == 0) && error("RegisterClass failed")
end   

function CreateWindow(className, width, height;
            drawStyle = WinExStyle.CLIENTEDGE,
            frameStyle = WinStyle.OVERLAPPEDWINDOW, 
            title = "Julia Window",
            x = CW_USEDEFAULT,
            y = CW_USEDEFAULT,
            parent = C_NULL,
            menu = C_NULL,
            hInstance = C_NULL,
            lpParam = C_NULL)

    ccall((:CreateWindowExW, _u32), HWND,
          (DWORD, LPCTSTR, LPCTSTR, DWORD,
           Cint, Cint, Cint, Cint,
           HWND, HMENU, HINSTANCE, LPVOID),
           drawStyle,
           pointer(utf16(className)), pointer(utf16(title)),
           frameStyle,
           x, y, width, height,
           parent, menu, hInstance, lpParam)
end

function ShowWindow(class::HWND; state = SW.SHOWNORMAL)
    # Returns true if window was hidden, else false
    r = ccall((:ShowWindow, _u32), Cuint,
            (HANDLE, Cuint), class, state)
end

function UpdateWindow(window)
    ccall((:UpdateWindow, _u32), Cuint, (HWND,), window)
end

GetMessage(msg) = ccall((:GetMessageW, _u32), Cuint,
                     (Ptr{Cuint}, Cuint, Cuint, Cuint),
                      msg, C_NULL, 0, 0)

end # module WinWin
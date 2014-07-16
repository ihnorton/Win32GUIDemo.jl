module Win32GUI

const _u32 = "User32.dll"
const _k32 = "Kernel32.dll"

include("win32guidefs.jl")

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
    ccall((:ShowWindow, _u32), Cuint,
          (HANDLE, Cuint), class, state)
end

function UpdateWindow(window)
    ccall((:UpdateWindow, _u32), Cuint, (HWND,), window)
end

function GetMessage(msg)
    ccall((:GetMessageW, _u32), Cuint,
            (Ptr{Cuint}, Cuint, Cuint, Cuint),
            msg, C_NULL, 0, 0)
end

function LoadLibrary(fileName)
    ccall((:LoadLibraryW, _k32), HMODULE, (LPCTSTR,), pointer(utf16(fileName)))
end

const RICHEDIT_CLASS = "RICHEDIT50W"

function BuildRichEdit(owner::HWND,
                       width, height;
                       x = CW_USEDEFAULT,
                       y = CW_USEDEFAULT,
                       hInstance::HINSTANCE = C_NULL)
    
    # TODO: msftedit is only available in XP-SP1+, but
    #       functionality can be made backwards compatible
    LoadLibrary("Msftedit.dll") == 0 &&
        error("Dll load failed: Msftedit.dll")
                       
    handle = CreateWindow(RICHEDIT_CLASS, width, height;
                          x = x, y = y,
                          title = "Type here",
                          frameStyle = EditStyle.MULTILINE |
                                       WinStyle.VISIBLE |
                                       WinStyle.CHILD |
                                       WinStyle.BORDER |
                                       WinStyle.TABSTOP,
                          parent = owner)
end
            
immutable COLORREF
    color::Cuint
    
    function COLORREF(r,g,b)
        if (r > 0xFF) || (g > 0xFF) || (b > 0xFF)
            error("RGB: component out of range")
        end
        0x00000000 & (r << 16) & (g << 8) & (b)
    end
end

const CLR_NONE      = 0xFFFFFFFF
const CLR_INVALID   = CLR_NONE
            
function SetBkColor(hdc::HDC, color::COLORREF)
    ccall((:SetBkColor, _u32), COLORREF,
           (HDC, COLORREF), hdc, color)
    # returns last color
end

end # module WinWin
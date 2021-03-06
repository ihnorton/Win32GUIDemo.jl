module WinDemo

###############################################################################
include("win32gui.jl")
for n in filter(x->x!=:eval, names(Win32GUI,true))
    eval(Expr(:import, :., :Win32GUI, n))
end
###############################################################################


function wincb(hwnd::HWND, msg::Cuint, wParam::WPARAM, lParam::LPARAM)
    
    if (msg == WM.SETBKGNDCOLOR)
        #hdc = convert(Ptr{HDC}, wParam)
        println("got COLOREDIT")
    elseif (WM.SIZE == msg)
        println("got size")

    end

    ccall((:DefWindowProcW, _u32), LRESULT,
          (HWND, Cuint, WPARAM, LPARAM),
          hwnd, msg, wParam, lParam)
    #return convert(LRESULT, 0)::LRESULT
end

function update_loop(msg)
    if (GetMessage(msg) > 0)
        ccall( (:TranslateMessage, _u32), Cuint, (Ptr{Cuint},), msg)
        ccall( (:DispatchMessageW, _u32), Cuint, (Ptr{Cuint},), msg)
    end
end

function run()
    window_cb = cfunction(wincb, LRESULT, (HWND, Cuint, WPARAM, LPARAM))
    
    # Create window
    winclassname = "TestWindow"

    RegisterClass(pointer([WNDCLASSEX(winclassname, window_cb, C_NULL)]))
    _win = CreateWindow(winclassname, 240, 120)
    
    richedit = BuildRichEdit(_win, CW_USEDEFAULT, CW_USEDEFAULT)
    
    # Display window
    ShowWindow(_win)
    UpdateWindow(_win)
    
    # Start event loop
    msg = Cuint[0]
    start_timer(Timer(x -> update_loop(msg)), .1, .005)
end

run()
main_quit = Condition()
wait(main_quit)

end # module WinDemo
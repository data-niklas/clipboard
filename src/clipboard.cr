module Clipboard
    @[Link(ldflags: "-L/lib/ -I/lib/ -lclipboard -lxcb")]
    lib LibClip
        type Clipboard_C = Void*
        type Clipboard_Opts = Void*
        enum Clipboard_Mode
            LCB_CLIPBOARD
            LCB_PRIMARY
            LCB_SECONDARY
            LCB_MODE_END
        end
        fun set_text = clipboard_set_text(cb : Clipboard_C*, text : LibC::Char*) : Bool
        fun set_text_ex = clipboard_set_text_ex(cb : Clipboard_C*, text : LibC::Char*, length : LibC::Int, mode : Clipboard_Mode) : Bool
        fun get_text = clipboard_text(cb : Clipboard_C*) : LibC::Char*
        fun get_text_ex = clipboard_text_ex(cb : Clipboard_C*, length : LibC::Int*, mode : Clipboard_Mode) : LibC::Char*
        fun has_ownership? = clipboard_has_ownership(cb : Clipboard_C*, mode : Clipboard_Mode) : Bool
        fun clear = clipboard_clear(cb : Clipboard_C*, mode : Clipboard_Mode) : Void
        fun free = clipboard_free(cb : Clipboard_C*) : Void
        fun new = clipboard_new(opts : Clipboard_Opts*) : Clipboard_C*
    end

    def self.get_text()
        clip = LibClip.new(nil)
        text = LibClip.get_text clip
        LibClip.free clip
        String.new(text)
    end

    # Won't work, if the program exits directly
    # It needs some time (try ~ 100 milliseconds minimum) for other applications to be able to access the clipboard
    # Else the clipboard will be empty, but get_text will return the correct value
    def self.set_text(text)
        clip = LibClip.new(nil)
        LibClip.set_text clip, text
    end

    def self.clear()
        clip = LibClip.new(nil)
        LibClip.clear clip, LibClip::Clipboard_Mode::LCB_CLIPBOARD
        LibClip.free clip
    end

end
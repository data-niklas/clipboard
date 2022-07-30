module Clipboard
    @[Link(ldflags: "-L/lib/ -I/lib/ -lclipboard -lxcb")]
    lib LibClip
        type ClipboardC = Void*
        type ClipboardOpts = Void*
        enum ClipboardMode
            LCB_CLIPBOARD
            LCB_PRIMARY
            LCB_SECONDARY
            LCB_MODE_END
        end
        fun set_text = clipboard_set_text(cb : ClipboardC*, text : LibC::Char*) : Bool
        fun set_text_ex = clipboard_set_text_ex(cb : ClipboardC*, text : LibC::Char*, length : LibC::Int, mode : ClipboardMode) : Bool
        fun get_text = clipboard_text(cb : ClipboardC*) : LibC::Char*
        fun get_text_ex = clipboard_text_ex(cb : ClipboardC*, length : LibC::Int*, mode : ClipboardMode) : LibC::Char*
        fun has_ownership? = clipboard_has_ownership(cb : ClipboardC*, mode : ClipboardMode) : Bool
        fun clear = clipboard_clear(cb : ClipboardC*, mode : ClipboardMode) : Void
        fun free = clipboard_free(cb : ClipboardC*) : Void
        fun new = clipboard_new(opts : ClipboardOpts*) : ClipboardC*
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
        LibClip.clear clip, LibClip::ClipboardMode::LCB_CLIPBOARD
        LibClip.free clip
    end

end

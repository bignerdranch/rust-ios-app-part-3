use libc::size_t;

// Helper struct that we'll use to give strings to C.
#[repr(C)]
pub struct RustByteSlice {
    pub bytes: *const u8,
    pub len: size_t,
}

impl<'a> From<&'a str> for RustByteSlice {
    fn from(s: &'a str) -> Self {
        RustByteSlice{
            bytes: s.as_ptr(),
            len: s.len() as size_t,
        }
    }
}

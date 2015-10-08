use libc::c_void;
use std::thread;
use std::ops::Deref;

#[repr(C)]
pub struct SwiftObject {
    user: *mut c_void,
    destroy: extern fn(user: *mut c_void),
    callback_with_int_arg: extern fn(user: *mut c_void, arg: i32),
}

unsafe impl Send for SwiftObject {}

struct SwiftObjectWrapper(SwiftObject);

impl Deref for SwiftObjectWrapper {
    type Target = SwiftObject;

    fn deref(&self) -> &SwiftObject {
        &self.0
    }
}

impl Drop for SwiftObjectWrapper {
    fn drop(&mut self) {
        (self.destroy)(self.user);
    }
}

#[no_mangle]
pub extern fn give_object_to_rust(obj: SwiftObject) {
    println!("moving SwiftObject onto a new thread created by Rust");
    let obj = SwiftObjectWrapper(obj);
    thread::spawn(move||{
        thread::sleep_ms(1000);
        (obj.callback_with_int_arg)(obj.user, 10);
    });
}

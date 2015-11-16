use libc::size_t;

use ::strings::RustByteSlice;

#[derive(Debug)]
pub struct NamedData {
    name: String,
    data: Vec<i32>,
}

impl Drop for NamedData {
    fn drop(&mut self) {
        println!("{:?} is being deallocated", self);
    }
}

#[no_mangle]
pub extern fn named_data_new() -> *mut NamedData {
    let named_data = NamedData{
        name: "some data".to_string(),
        data: vec![1, 2, 3, 4, 5],
    };
    let boxed_data = Box::new(named_data);
    Box::into_raw(boxed_data)
}

#[no_mangle]
pub unsafe extern fn named_data_destroy(data: *mut NamedData) {
    let _ = Box::from_raw(data);
}

#[no_mangle]
pub unsafe extern fn named_data_get_name(named_data: *const NamedData) -> RustByteSlice {
    let named_data = &*named_data;
    RustByteSlice::from(named_data.name.as_ref())
}

#[no_mangle]
pub unsafe extern fn named_data_count(named_data: *const NamedData) -> size_t {
    let named_data = &*named_data;
    named_data.data.len() as size_t
}

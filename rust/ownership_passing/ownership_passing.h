#pragma once

#include <stdint.h>

// -----------------------------------------------------------------------
// from strings.rs
// -----------------------------------------------------------------------
struct RustByteSlice {
    const uint8_t *bytes;
    size_t len;
};

// -----------------------------------------------------------------------
// from rust_to_swift.rs
// -----------------------------------------------------------------------
struct named_data;

// Create a new instance of `named_data`.
// The caller is responsible for passing the returned pointer to
// named_data_destroy, or memory will be leaked.
struct named_data *named_data_new(void);

// Free a `named_data` instance returned by `named_data_new`.
void named_data_destroy(struct named_data *data);

// Get the name of a `named_data`. The returned byte slice is valid until
// the `named_data` instance is destroyed.
struct RustByteSlice named_data_get_name(const struct named_data *data);

// Get the number of elements stored in `data`.
size_t named_data_count(const struct named_data *data);

// -----------------------------------------------------------------------
// from swift_to_rust.rs
// -----------------------------------------------------------------------

struct swift_object {
    void *user;
    void (*destroy)(void *user);
    void (*callback_with_int_arg)(void *user, int32_t arg);
};

void give_object_to_rust(struct swift_object object);

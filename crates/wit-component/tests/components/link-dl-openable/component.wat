(component
  (type (;0;)
    (instance
      (type (;0;) (func (param "v" s32) (result s32)))
      (export (;0;) "foo" (func (type 0)))
    )
  )
  (import (interface "test:test/test") (instance (;0;) (type 0)))
  (core module (;0;)
    (table (;0;) 3 funcref)
    (memory (;0;) 17)
    (global (;0;) (mut i32) i32.const 1048576)
    (global (;1;) i32 i32.const 1048688)
    (global (;2;) i32 i32.const 3)
    (global (;3;) (mut i32) i32.const 1048688)
    (global (;4;) (mut i32) i32.const 1114112)
    (export "__stack_pointer" (global 0))
    (export "foo:memory_base" (global 1))
    (export "foo:table_base" (global 2))
    (export "__heap_base" (global 3))
    (export "__heap_end" (global 4))
    (export "__indirect_function_table" (table 0))
    (export "memory" (memory 0))
    (@producers
      (processed-by "wit-component" "$CARGO_PKG_VERSION")
    )
  )
  (core module (;1;)
    (@dylink.0
      (mem-info (memory 0 4))
    )
    (type (;0;) (func (param i32) (result i32)))
    (import "test:test/test" "foo" (func $import_foo (;0;) (type 0)))
    (func $foo (;1;) (type 0) (param i32) (result i32)
      unreachable
    )
    (global $what (;0;) i32 i32.const 42)
    (export "test:test/test#foo" (func $foo))
    (export "bar" (func $foo))
    (export "baz" (func $foo))
    (export "what" (global $what))
  )
  (core module (;2;)
    (type (;0;) (func))
    (type (;1;) (func (param i32)))
    (type (;2;) (func (param i32) (result i32)))
    (type (;3;) (func (param i32) (result i32)))
    (type (;4;) (func (param i32) (result i32)))
    (import "env" "memory" (memory (;0;) 0))
    (import "env" "__indirect_function_table" (table (;0;) 0 funcref))
    (import "env" "foo:memory_base" (global (;0;) i32))
    (import "foo" "what" (global (;1;) i32))
    (import "foo" "bar" (func (;0;) (type 2)))
    (import "foo" "baz" (func (;1;) (type 3)))
    (import "foo" "test:test/test#foo" (func (;2;) (type 4)))
    (func (;3;) (type 0)
      i32.const 1048656
      global.get 0
      global.get 1
      i32.add
      i32.store
    )
    (start 3)
    (elem (;0;) (i32.const 0) func 0 1 2)
    (elem (;1;) (i32.const 3) func)
    (data (;0;) (i32.const 1048576) "foo\00bar\00baz\00test:test/test#foo\00\00what\03\00\00\00\04\00\10\00\00\00\00\00\03\00\00\00\08\00\10\00\01\00\00\00\12\00\00\00\0c\00\10\00\02\00\00\00\04\00\00\00 \00\10\00\00\00\00\00\03\00\00\00\00\00\10\00\04\00\00\00$\00\10\00\01\00\00\00T\00\10\00")
    (@producers
      (processed-by "wit-component" "$CARGO_PKG_VERSION")
    )
  )
  (core instance (;0;) (instantiate 0))
  (alias core export 0 "memory" (core memory (;0;)))
  (alias core export 0 "__heap_base" (core global (;0;)))
  (alias core export 0 "__heap_end" (core global (;1;)))
  (core instance (;1;)
    (export "__heap_base" (global 0))
    (export "__heap_end" (global 1))
  )
  (core instance (;2;))
  (alias core export 0 "memory" (core memory (;1;)))
  (alias core export 0 "__indirect_function_table" (core table (;0;)))
  (alias core export 0 "__stack_pointer" (core global (;2;)))
  (alias core export 0 "foo:memory_base" (core global (;3;)))
  (alias core export 0 "foo:table_base" (core global (;4;)))
  (core instance (;3;)
    (export "memory" (memory 1))
    (export "__indirect_function_table" (table 0))
    (export "__stack_pointer" (global 2))
    (export "__memory_base" (global 3))
    (export "__table_base" (global 4))
  )
  (alias export 0 "foo" (func (;0;)))
  (core func (;0;) (canon lower (func 0)))
  (core instance (;4;)
    (export "foo" (func 0))
  )
  (core instance (;5;) (instantiate 1
      (with "GOT.mem" (instance 1))
      (with "GOT.func" (instance 2))
      (with "env" (instance 3))
      (with "test:test/test" (instance 4))
    )
  )
  (core instance (;6;) (instantiate 2
      (with "env" (instance 0))
      (with "foo" (instance 5))
    )
  )
  (type (;1;) (func (param "v" s32) (result s32)))
  (alias core export 5 "test:test/test#foo" (core func (;1;)))
  (func (;1;) (type 1) (canon lift (core func 1)))
  (component (;0;)
    (type (;0;) (func (param "v" s32) (result s32)))
    (import "import-func-foo" (func (;0;) (type 0)))
    (type (;1;) (func (param "v" s32) (result s32)))
    (export (;1;) "foo" (func 0) (func (type 1)))
  )
  (instance (;1;) (instantiate 0
      (with "import-func-foo" (func 1))
    )
  )
  (export (;2;) (interface "test:test/test") (instance 1))
  (@producers
    (processed-by "wit-component" "$CARGO_PKG_VERSION")
  )
)
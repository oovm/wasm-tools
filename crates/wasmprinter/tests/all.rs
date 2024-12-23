#[test]
fn no_oom() {
    // Whatever is printed here, it shouldn't take more than 500MB to print
    // since it's only 20k functions.
    let mut s = String::new();
    s.push_str("(module\n");
    for _ in 0..20_000 {
        s.push_str("(func if)\n");
    }
    s.push(')');
    let bytes = wat::parse_str(&s).unwrap();
    let wat = wasmprinter::print_bytes(&bytes).unwrap();
    assert!(wat.len() < 500_000_000);
}

const MODULE_1: &str = r#"
    (;@0     ;) (module
    (;@b     ;)   (type (;0;) (func (param i32) (result i32)))
    (;@1f    ;)   (func (;0;) (type 0) (param i32) (result i32)
    (;@20    ;)     local.get 0
                  )
    (;@17    ;)   (export "f" (func 0))
                )
"#;

#[test]
fn offsets_and_lines_smoke_test() {
    let bytes = wat::parse_str(MODULE_1).unwrap();

    let mut storage = String::new();
    let actual: Vec<_> = wasmprinter::Config::new()
        .offsets_and_lines(&bytes, &mut storage)
        .unwrap()
        .collect();

    #[rustfmt::skip]
    let expected = vec![
        (Some(0),    "(module\n"),
        (Some(0xb),  "  (type (;0;) (func (param i32) (result i32)))\n"),
        (Some(0x17), "  (export \"f\" (func 0))\n"),
        (Some(0x1f), "  (func (;0;) (type 0) (param i32) (result i32)\n"),
        (Some(0x20), "    local.get 0\n"),
        (None,       "  )\n"),
        (None,       ")\n"),
        (Some(0x23), ""),
    ];

    assert_eq!(actual, expected);
}

#[test]
fn custom_indent_text() {
    let bytes = wat::parse_str(MODULE_1).unwrap();

    let mut storage = String::new();
    let actual: Vec<_> = wasmprinter::Config::new()
        .indent_text('\t')
        .offsets_and_lines(&bytes, &mut storage)
        .unwrap()
        .collect();

    #[rustfmt::skip]
    let expected = vec![
        (Some(0),    "(module\n"),
        (Some(0xb),  "\t(type (;0;) (func (param i32) (result i32)))\n"),
        (Some(0x17), "\t(export \"f\" (func 0))\n"),
        (Some(0x1f), "\t(func (;0;) (type 0) (param i32) (result i32)\n"),
        (Some(0x20), "\t\tlocal.get 0\n"),
        (None,       "\t)\n"),
        (None,       ")\n"),
        (Some(0x23), ""),
    ];

    assert_eq!(actual, expected);
}

use std::process::Command;

fn main() {
    // get text from pasteboard
    let s = paste();
    println!("{}", add_quotes(escape(&s)));
}

fn paste() -> String {
    let output = Command::new("pbpaste")
        .output()
        .expect("Failed to execute command");
    String::from_utf8_lossy(&output.stdout).to_string()
}

fn escape(s: &str) -> String {
    // replace newline to literal \n
    // replace " to literal "

    let mut escaped: String = s.to_string();
    escaped = escaped.replace(r#"\"#, r#"\\"#);
    escaped = escaped.replace("\n", r#"\n"#);
    escaped = escaped.replace(r#"""#, r#"\""#);
    escaped
}

fn add_quotes(s: String) -> String {
    format!(r#""{}""#, s)
}

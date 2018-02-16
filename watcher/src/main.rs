extern crate notify;

use notify::{watcher, RecursiveMode, Watcher};
use std::sync::mpsc::channel;
use std::time::Duration;
use std::process::Command;
use notify::DebouncedEvent::Create;

fn main() {
    let (tx, rx) = channel();
    let mut watcher = watcher(tx, Duration::from_secs(10)).unwrap();
    let path = "C:\\Users\\pauli\\Sync\\github\\PELA-parametric-blocks";

    println!("Watching: {:?}", path);
    watcher.watch(path, RecursiveMode::NonRecursive).unwrap();

    loop {
        match rx.recv() {
            Ok(event) => receive_event(event),
            Err(e) => println!("watch error: {:?}", e),
        }
    }
}

fn receive_event(event: notify::DebouncedEvent) {
    println!("Event: {:?}", event);

    if let Create(pathbuff) = event {
        if let Some(filename) = pathbuff.as_path().file_name() {
            if let Some("start.txt") = filename.to_str() {
                execute_command(
                    "C:\\Users\\pauli\\Sync\\github\\PELA-parametric-blocks\\donothing.bat",
                );
            }
        }
    }
}

fn execute_command(command: &str) {
    println!("Execute: {:?}", command);

    let output = if cfg!(target_os = "windows") {
        Command::new("cmd")
            .args(&["/C", command])
            .output()
            .expect("failed to execute process")
    } else {
        Command::new("sh")
            .arg("-c")
            .arg(command)
            .output()
            .expect("failed to execute process")
    };

    let hello = output.stdout;
    let s = String::from_utf8_lossy(&hello);
    println!("Result: {:?}", s);
    println!();
}

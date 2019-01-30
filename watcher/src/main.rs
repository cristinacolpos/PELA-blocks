extern crate notify;

use notify::{watcher, RecursiveMode, Watcher};
use std::sync::mpsc::channel;
use std::env::*;
use std::time::Duration;
use std::process::Command;
use notify::DebouncedEvent::Create;

const FILE_TO_WATCH_FOR: &str = "start.txt";
const COMMAND_TO_EXECUTE: &str = "servermake.bat";

fn main() {
    let (tx, rx) = channel();
    let mut watcher = watcher(tx, Duration::from_secs(10)).expect("Can not init file watch");
    let path = current_directory();

    watcher
        .watch(path.clone(), RecursiveMode::NonRecursive)
        .expect("Can not start directory change watcher");

    println!("Watching: {}", path);
    println!(
        "Now create \"{}\" to trigger the action \"{}\"",
        FILE_TO_WATCH_FOR, COMMAND_TO_EXECUTE
    );

    loop {
        match rx.recv() {
            Ok(event) => receive_event(event),
            Err(e) => println!("watch error: {}", e),
        }
    }
}

fn current_directory() -> String {
    current_dir()
        .expect("Could not get current directory")
        .to_str()
        .expect("Could not parse current directory name")
        .into()
}

fn receive_event(event: notify::DebouncedEvent) {
    println!("Event: {:?}", event);

    if let Create(pathbuff) = event {
        if let Some(filename) = pathbuff.as_path().file_name() {
            if let Some(FILE_TO_WATCH_FOR) = filename.to_str() {
                execute_command(COMMAND_TO_EXECUTE);
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
            .expect(&format!("failed to execute Windows process: {}", command))
    } else {
        Command::new("sh")
            .arg("-c")
            .arg(command)
            .output()
            .expect(&format!("failed to execute side_shell process: {}", command))
    };

    let hello = output.stdout;
    let s = String::from_utf8_lossy(&hello);
    println!("Result: {}", s);
    println!();
}

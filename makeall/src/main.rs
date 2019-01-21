use std::fs;
use std::fmt;

struct Path<'a> {
    directory: &'a str,
    files: Vec<&'a str>,
}


impl<'a> Path<'a> {
    pub fn new(directory: &'a str) -> Path<'a> {        
        let p = Path {
            directory: directory,
            files: Vec::new(),
        };

        p
    }

    pub fn add(&mut self, file: &'a str) {
        self.files.push(file);
    }
}

impl<'a> fmt::Display for Path<'a> {
    pub fn fmt(&self, &mut std::fmt::Formatter<'_>) -> Result<(), std::fmt::Error> {

    }
}

fn main() {
    println!("Making all PELABlocks.org .stl models");

    let paths = Path::new("./");

    println!("Directory: {}", paths);
}


fn paths(path: &Path) {
    let paths = fs::read_dir(path.directory).unwrap();

    for path in paths {
        println!("Name: {}", path.unwrap().path().display())
    }
}
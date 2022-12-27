#!/bin/bash
start=$(pwd)
for file in $(find -name \*.code.md -type f -not -path ./_site\*); do
	cd $start
	# Create the test directory.
	mkdir -p test/$file/src
	# Extract the Rust code from the file, if any.
	cat $file | literate --required --language rust > test/$file/src/main.rs
	cat $file | literate --required --language toml > test/$file/Cargo.toml
	# Extract the JavaScript code from the file, if any.
	cat $file | literate --required --language js > test/$file/index.js
	cat $file | literate --required --language package.json > test/$file/package.json
	# Run the Rust code from the file, if any.
	if [ -s test/$file/Cargo.toml ]; then
		echo "Running Rust code from $file"
		cd test/$file && cargo build && cargo test && cargo run
		cd $start
	fi
	# Run the JavaScript code from the file, if any.
	if [ -s test/$file/package.json ]; then
		echo "Running JavaScript code from $file"
		cd test/$file && npm i && npm start
		cd $start
	fi
done
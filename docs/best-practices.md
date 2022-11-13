---
title: Best Practices
layout: home
---

This document contains information about programming best practices. The code snippets in this file are in Rust, but they are simple enough to be legible, and should apply to any language.

- [Indentation](#indentation)
- [Comments](#comments)
- [Test, Test, Test!](#test-test-test)
- [Never Trust the Client](#never-trust-the-client)

## Indentation

Use real tab characters for indentation, not spaces. This is a controversial topic, but using tabs improves the accessibility and customizability of your code at no cost to you.

<style>
	:root {
		--twid: 4ch;
	}
	* {
		tab-size: var(--twid);
  }
</style>

```rust
fn main() {
	println!("This code is indented with tabs.");
}

fn main() {
    println!("This code is indented with spaces.
    It looks the same, but it's slightly harder
    for people with impaired vision to read
    because they can't change the indentation
    width as easily.");
}
```

Tabs are important because they allow your peers to determine which indentation width is best for them. This document is currently using <input type="number" id="twid_demo" value="4" size=1>ch tabs. You can use that selector to change how tabs are rendered on this page, if you have JavaScript enabled.

<script>
document.querySelector("#twid_demo").addEventListener("input", event => {
	document.querySelector(":root").style.setProperty("--twid", `${event.target.value}ch`);
})
</script>

## Comments
Comment your code, but only if it isn't already clear what it does.

```rust
// This is excessive, and makes the program harder to read.
/// The main function of the program.
fn main() {
	// Takes out a lock on the standard output. This ensures that writes won't be interleaved when multithreading.
	let stdout = std::io::stdout().lock();
	// Push a pointer to the static "Hello, World" text on top of the stack.
	let hw = "Hello, world!\n";
	// Write the first six bytes of `hw` to stdout, calling unwrap in case the pipe was closed.
	stdout.write_all(&hw[..6]).unwrap();
	// Flush the standard output, otherwise the runtime would wait until we send a newline.
	stdout.flush().unwrap();
	// Wait several seconds.
	std::thread::sleep(Duration::from_secs(1));
	// Write the rest of the message.
	stdout.write_all(&hw[6..]).unwrap();
	// The program ends, which flushes the rest of the output.
}

// Only one of the lines really needed explanation.
fn main() {
	let stdout = std::io::stdout().lock();
	let hw = "Hello, world!\n";
	stdout.write_all(&hw[..6]).unwrap();
	// Flush stdout so it is written now instead of waiting for a newline.
	stdout.flush().unwrap();
	std::thread::sleep(Duration::from_secs(1));
	stdout.write_all(&hw[6..]).unwrap();
}
```

## Test, Test, Test!

It's easy to accidentally break something when adding a new feature, and we can't expect every developer to test every little edge case before they push their code. Instead, we can use "unit testing" and "integration testing". Some languages have built-in testing, while others may rely on a third-party testing framework.

"Unit testing" is the practice of writing special "test functions" that run automatically to check that every individual part of your project still works.

```rust
/// Function that needs to be tested for accuracy.
fn add_five(n: u32) -> u32 {
	return n + 5;
}

/// Function implementing the test.
#[test]
fn test_five() {
	assert_eq!(add_five(0), 5);
	assert_eq!(add_five(15), 20);
	assert_eq!(add_five(7), 12);
	assert_eq!(add_five(3), 8);
}
```

"Integration testing" is similar to unit testing, but it tests your project as a whole, instead of testing only small parts.

```rust
#[test]
fn test_big_thing() {
	// funny reference to cult classic media thing that i only have a superficial understanding of
	let deep_thought = your_library::SupernaturalComputer::new().expect("Construction Accident");
	assert_eq!(deep_thought.find_answer(), Ok(42));
	assert_eq!(deep_thought.find_question(), Err(your_library::Error::VogonBypass));
}
```

You likely already have experience with test-driven development if you've taken an online programming class, where your teacher will have set up a set of checks that your code has to pass. The only difference between that and real test-driven development is that you write both the tests and the code that fulfills them.

## Never Trust the Client

Assume that everything coming over the network is malicious, and that every little facet of your program's logic is being scrutinized by evil people much more skilled than you, and you'll be paranoid enough to write a decently secure network service.

It might be tempting to assume that if it's *your* software running on someone else's computer, you're safe from tampering, but you have no way of guaranteeing that the computer you're talking to is running the instructions you want it to. There have been many attempts to force clients to tell the truth for media DRM or video game anti-cheat, but fundamentally, the user has physical access to their computer, which means they can access everything it knows, and they can force it to lie to you.

---
title: Good Practices
layout: home
---

This document contains information about programming best practices that might help you avoid footguns in the future. The code snippets in this file are in Rust for legibility, but they are simple enough for beginners, and should apply to any language with the covered functionality.

None of the tips in this document are hard-and-fast rules!!! Use your discretion to decide when to follow them. Besides, I'm not your boss, I can't tell you how to do your job.

(This document is a draft, and the opinions therein are those of the author only.)

- [Indentation](#indentation)
- [Comments](#comments)
- [Choose a License](#choose-a-license)
- [Test, Test, Test!](#test-test-test)
- [Never Trust the Client](#never-trust-the-client)
- [Don't Repeat Yourself](#dont-repeat-yourself)
- [It walks like a duck and quacks like a duck..?](#it-walks-like-a-duck-and-quacks-like-a-duck)
- [Say What You Mean (Declarative Abstractions)](#say-what-you-mean-declarative-abstractions)
	- [Loops](#loops)
	- [Enums](#enums)

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

## Choose a License

Having your source code available on the internet is all well and good, but people will be hesitant to use it unless you explain exactly what they can and cannot do with it. Legalese isn't anyone's first language, but some decently fluent speakers have written a plethora of cookie-cutter licenses under which you can release your project. The following are some examples (but not legal advice):

* AGPL-3.0 - The strongest license. Users must release any modifications they make, and any project they use your code in, under the AGPL-3.0, to anyone who interacts with it, including over a network, and they must provide resources for compiling and deploying one's own modified version.
* LGPL-3.0 - Users may distribute your project as part of a proprietary program, but they must clearly separate your project from theirs as a separate file, and they must publish any modifications they make.
* MIT - Anything goes, as long as the user includes a copy of the MIT license document, credits the author, and does not attempt to hold them liable for any damages the software causes.
* Apache-2.0 - Anything goes, as long as the user includes a copy of the Apache license document, states their changes, changes the logo, and includes any notices bundled with the software.
* Unlicense - The weakest license. Anything goes, as long as the user does not hold the author liable. The project is part of the public domain.

For more thourough explanations and full license texts, see [TLDRLegal](https://tldrlegal.com/).

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

## Don't Repeat Yourself

When writing code that handles multiple cases, you might find that you're writing very similar code several times. This is obviously not ideal. For example:

```rust
// These functions are very similar...
fn add_u8(a: u8, b: u8) -> u8 { a + b }
fn add_u16(a: u16, b: u16) -> u16 { a + b }
fn add_u32(a: u32, b: u32) -> u32 { a + b }
...

// We can fix this by writing a generic function!
fn add<T: Add<...>>(a: T, b: T) -> T { a + b }
```

You might be able to deduplicate code by writing generic functions, moving repeated sections into functions of their own, or using macros to write repetitive code for you.

## It walks like a duck and quacks like a duck..?

*But it wasn't a duck, it was* `[0]`.

Languages like Javascript are "dynamically typed languages". They still have a type system, of course, but they do their best to keep it out of your way. Unfortunately, things which linger out of sight often also fall out of mind, which means that dynamic type systems are usually [unpredictable](https://medium.com/intrinsic-blog/javascript-prototype-poisoning-vulnerabilities-in-the-wild-7bc15347c96), [extremely inconsistent](https://dorey.github.io/JavaScript-Equality-Table/), and [generally awful](https://jscrew.it/). Not having to think about a type system can make writing code easier, but the resultant program can be nearly illegible without an IDE to help you decipher it.

Ideally, production code should be written in a strongly-typed language, to ensure that your colleagues will still be able to read it a decade down the line.

For JavaScript, you can port your JavaScript code to TypeScript. TypeScript can check your types at compile time and generate JavaScript that will do its best to enforce them at runtime.

## Say What You Mean (Declarative Abstractions)

There are often multiple ways to write the same code. If the language you're using offers it, it can be helpful to use declarative abstractions to write what you want to happen, rather than writing what the computer will do to accomplish that.

### Loops

Loops are a familiar control structure, and they work perfectly well, but they are closer to the compiler's understanding of the world than they are to yours. Consider this snippet:

```rust
let a = [1, 2, 3, 4];
let mut b = vec![];

for value in a {
	b.push(value * 2);
}
```

This code is written for the compiler, and it describes exactly what the computer will do: it allocates an input and an output, walks through every value in the input, multiplies that value by two, and pushes it to the output. Instead consider this code:

```rust
let a = [1, 2, 3, 4];
let b = a.iter()
	.map(|v| v * 2)
	.collect::<Vec<_>>();
```

It describes what we actually *want* to do: take the contents of A, multiply them by two, and place them into B. In JavaScript, `Array.map`, `Array.filter`, and `Array.reduce` implement declarative abstractions for some common loop algorithms. For some languages, this type of operation will also be considerably faster than implementing it yourself using a loop.

### Enums

When programming, we often want to store some finite set of valid states. An integer or string will work for this, but it creates the opportunity for confusion if that value somehow escapes those valid states.

```rust
fn do_the_thing(state: u8) -> ... {
	match state {
		0 => ...,
		1 => ...,
		2 => ...,
		_ => panic!("Passed invalid state!!!"),
	}
}
```

If you never set `state` to an invalid value, nothing will go wrong, but there's no guarantee you'll actually stick with that, and unexpected bad things could happen if you slip up. Instead, you can use an enum to guarantee that the value will only ever be valid.

```rust
enum State {
	Zero,
	One,
	Two,
}

fn do_the_thing(state: State) -> ... {
	match state {
		Zero => ...,
		One => ...,
		Two => ...,
	}
}
```

When using an enum, many compilers will also check to make sure you actually handled every valid state, instead of leaving it up to you. Unfortunately, JavaScript doesn't have support for this, but TypeScript does.

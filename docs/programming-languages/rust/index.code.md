---
title: Rust
layout: home
parent: Programming Languages
---

{% comment %}

```toml
[package]
name = "rust-examples"
version = "0.0.1"
```

```rust
#![allow(dead_code)]
#![allow(unused_assignments)]
#![allow(unused_variables)]

use std::mem::drop as foobar;

fn get_thing() -> i32 {42}

fn main() {}
```

{% endcomment %}

Rust is a modern high-level programming language.

## Features of Rust

* Helpful compiler
  * Most mistakes you can make will have a concise explanation of what is wrong and what might fix the problem
* Performance within 10% of C
* Memory safety is guaranteed at compile-time
* No garbage-collection pauses
* Can target most environments
  * Bare-metal, embedded, game console homebrew, command-line and graphical applications, network services, and the client-side web all work well with Rust
* Infinite metaprogramming
  * Macros in Rust are real Rust programs that run at compile-time, so they can do anything you could possibly want them to do
* Functional-like features
  * Declarative iterators, immutability by default, etc
* Design by composition
  * "Traits", like interfaces in other languages, allow for generic code reuse without the pitfalls of design by inheritance
* Unsafe code blocks allow for low-level operations when necessary
* Excellent libraries for many applications
* Fearless concurrency
  * The borrow checker ensures that any given data can have N readers *or* one writer, so it is impossible to cause a race condition or torn write.

## Antifeatures of Rust

* Fairly long compile times by default
* Verbose syntax may be difficult at first
* Certain data structures cannot be implemented without unsafe code
* Object-oriented design may be unfamiliar because classes are split into structs and impls
* Strong typing may be unfamiliar to users of weakly typed languages
* Your first instinct for how to design your program may not be possible to implement within the constraints imposed by the borrow checker

## Getting started with Rust

As a first taste, you should read [@fasterthanlime](https://octodon.social/@fasterthanlime)'s article, [A half-hour to learn Rust](https://fasterthanli.me/articles/a-half-hour-to-learn-rust), or watch [@0atman](https://mastodon.social/@0atman)'s video based on the article, [Rust for the impatient](https://www.youtube.com/watch?v=br3GIIQeefY).

There are several options for getting more experience in Rust.

* You could get more theoretical information from the [Rust book](https://doc.rust-lang.org/stable/book/). It's fairly long, but it teaches everything about the language and includes several projects to try.
* For a different type of reading, you can try [Rust by Example](https://doc.rust-lang.org/stable/rust-by-example/), a book of code snippets demonstrating language features.
* To get practical experience, you can go through [Rustlings](https://github.com/rust-lang/rustlings),  [Exercism](https://exercism.org)'s Rust track, or you can try some problems on [Leetcode](https://leetcode.com) with Rust.

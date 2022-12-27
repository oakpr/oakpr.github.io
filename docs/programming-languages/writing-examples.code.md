---
title: Writing Code Examples
parent: Programming Languages
layout: home
---

The script in the root of this repository implements automatic documentation checks. Checks are currently only available for Rust and NodeJS, but support for other languages or runtimes can be added. Currently, checks are not run by Github Actions before publishing the page, but this will be the case in the future. Files with code examples must use the file extension `.code.md` to be checked.

Typically, you should hide the start of your code example to reduce clutter. You can do this with Jekyll tags, like this:

{% raw %}`{% comment %}`{% endraw %}

(Rust examples need to have a toml section with the contents of Cargo.toml, or they will not run.)

```toml
[package]
name = "checked-example"
version = "0.0.1"
```

```rust
fn main(){
```

(JavaScript examples need to have a json section with the contents of package.json, or they will not run. To include json without treating it as package.json, just set the format to JavaScript instead.)

```json
{
	"entry": "index.js",
	"scripts": {
		"start": "node ."
	}
}
```

{% raw %}`{% endcomment %}`{% endraw %}

Then, you can include the "meat" of your example in the middle...

```rust
println!("Hello, world!");
```

```js
console.log("Hello, world!");
```


{% raw %}`{% comment %}`{% endraw %}

If your program has a tail as well, you can include it in another pair of comment tags.

```rust
}
```

{% raw %}`{% endcomment %}`{% endraw %}

The check script depends on a program called `literate`. You can install this program with `cargo install literate`. You can run the checks by simply calling the check script in your shell, like this:

```bash
./check.sh
```
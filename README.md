# Lua Coroutine

This work is devoted to God.

A library for working with coroutines. This can help other add-on creators to save some work.

## Functions included

* **Coroutine.runAsCoroutine** a function that runs the given function as coroutine the next frame.
* **Coroutine.runAsCoroutineImmediately** a function that runs the give function as coroutine this frame.
* **Coroutine.resumeWithShowingError** a function which resumes the coroutine and supports showing the error when the coroutine throws one.

**The following functions can be used inside coroutines:**

* **Coroutine.waitFor** a function that waits until a function (predicate) returns true. An optional timeout is supported.
* **Coroutine.waitUntil** the same function as Coroutine.waitFor with a semantically different name.
* **Coroutine.waitForDuration** a function that waits for a specific duration.
* **Coroutine.yieldAndResume** a function which yields and schedules a resume.

You can support me on [Patreon](https://www.patreon.com/addons_by_sanjo).

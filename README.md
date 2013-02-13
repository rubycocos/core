# logutils

Another Logger in Ruby

Logging levels:

* DEBUG
* INFO
* WARN
* ERROR
* FATAL


## Dev Notes

### How to get process id (pid)?

* Yell uses   Process.pid
* Logging ???
* Log4r

### How to get thread id (tid)?

* Yell uses   Thread.current.object_id
* Logging ???
* Log4r ???

### How to get timestamp (ts)?

* Yell uses   Time.now

### How to get filename, line, method?

use caller ?

## Alternatives

* [Ruby Toolbox Logging Category](https://www.ruby-toolbox.com/categories/Logging)
* [log4r]()
* [slf4r](https://www.ruby-toolbox.com/projects/slf4r)
* [yell]()
* [logging](https://rubygems.org/gems/logging)

## License

The `logutils` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
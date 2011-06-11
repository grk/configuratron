# Configuratron ![build status](http://travis-ci.org/grk/configuratron.png)

Configuratron is a library for storing configuraion. Objects of this
class can access internal storage with a hash-like interface or method
access:

```ruby
require 'configuratron'
c = Configuratron.new
c[:setting] = :value
c[:setting] # => :value
c.other_setting = :other_value
c.other_setting # => :other_value
```

Method-based access is done by `method_missing`, but on first access the
missing method is defined.

## `Configurable` module

The `Configuratron::Configurable` module can either be included in a
class, or extend it. When included, it will define a `config` method
in instances of that class; when extended, it will define a `config`
method for this class.

The `config` method returns a memoized instance of `Configuratron`.

## License

This project is released under the MIT license. See LICENSE for more
details.

# props-activerecord

Manage Setting Hierarchies Addon for Database Support (ConfDb, Props Model, etc.)

* home  :: [github.com/rubycoco/core](https://github.com/rubycoco/core)
* bugs  :: [github.com/rubycoco/core/issues](https://github.com/rubycoco/core/issues)
* gem   :: [rubygems.org/gems/props-activerecord](https://rubygems.org/gems/props-activerecord)
* rdoc  :: [rubydoc.info/gems/props-activerecord](http://rubydoc.info/gems/props-activerecord)


## Usage

### DB - Config Database / Schema / Model

Example:

```
require 'props/activerecord'       # include database support

ConfDb.create    # build schema / tables (props)

Prop.create!( key: 'db.schema.version', '1.0.0' )

puts "Props:"
Prop.order( 'created_at asc' ).all.each do |prop|
  puts "  #{prop.key} / #{prop.value} | #{prop.created_at}"
end
```

More examples:

```
ConfDb.tables     # dump stats to console
ConfDb.delete!    # delete all records
```


## License

The `props-activerecord` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

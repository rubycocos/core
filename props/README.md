# `props` -  Manage Settings Hierarchies (Commandline, User, Home, Defaults, etc.)

* home  :: [github.com/rubylibs/props](https://github.com/rubylibs/props)
* bugs  :: [github.com/rubylibs/props/issues](https://github.com/rubylibs/props/issues)
* gem   :: [rubygems.org/gems/props](https://rubygems.org/gems/props)
* rdoc  :: [rubydoc.info/gems/props](http://rubydoc.info/gems/props)


## Usage

### Props

Example:

``` ruby
class Config

  DEFAULTS = { 'libs' => [ 'kramdown' ],
               'extnames' => [
                 '.markdown',
                 '.m',
                 '.mark',
                 '.mkdn',
                 '.md',
                 '.mdown',
                 '.markdn',
                 '.txt',
                 '.text' ],
                'redcarpet' => {
                 'extensions' => [
                    'no_intra_emphasis',
                    'fenced_code_blocks',
                    'tables',
                    'strikethrough' ] }
             }

  def initialize
    @props = @props_default = Props.new( DEFAULTS, 'DEFAULTS' )

    # check for user settings (markdown.yml) in home folder

    props_home_file = File.join( Env.home, 'markdown.yml' )
    if File.exists?( props_home_file )
      puts "Loading settings from '#{props_home_file}'..."
      @props = @props_home = Props.load_file( props_home_file, @props )
    end

    # check for user settings (markdown.yml) in working folder

    props_work_file = File.join( '.', 'markdown.yml' )
    if File.exists?( props_work_file )
      puts "Loading settings from '#{props_work_file}'..."
      @props = @props_work = Props.load_file( props_work_file, @props )
    end
  end

  def markdown_extnames
    @props.fetch( 'extnames', nil )
  end

  ...

end # class Config
```


### Environment

Example:

``` ruby
puts Env.home
# => '/home/gerald'
```

Backstage the `Env.home` code looks something like:

``` ruby
path = if( ENV['HOME'] || ENV['USERPROFILE'] )
         ENV['HOME'] || ENV['USERPROFILE']
       elsif( ENV['HOMEDRIVE'] && ENV['HOMEPATH'] )
         "#{ENV['HOMEDRIVE']}#{ENV['HOMEPATH']}"
       else
         begin
            File.expand_path('~')
         rescue
            if File::ALT_SEPARATOR
               'C:/'
            else
               '/'
            end
         end
       end
```


`Env.path` returns `ENV[ 'PATH' ]` - splits all path entries
 w/ file separator (e.g. `;` or `:`) and returns string array

``` ruby
puts Env.path
# => ['/usr/local/sbin',
#      '/usr/local/bin',
#      '/usr/sbin',
#      ...
#     ]
```



## Install

Just install the gem:

    $ gem install props



## Real World Usage

The [`slideshow`](http://slideshow-s9.github.io) gem (also known as Slide Show (S9))
that lets you create slide shows
and author slides in plain text using a wiki-style markup language that's easy-to-write and easy-to-read.

The [`pluto`](http://feedreader.github.io) gem
that lets you auto-build web pages from web feeds.

The [`markdown`](https://github.com/rubylibs/markdown) gem that lets you use your markdown library
of choice.



## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `props` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Post them to the [wwwmake forum](http://groups.google.com/group/wwwmake). Thanks!

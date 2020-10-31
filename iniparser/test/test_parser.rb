# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_parser.rb


require 'helper'


class TestParser < MiniTest::Test

  def test_load

    text = <<TXT
  # comment
  ; another comment

   key1 = hello
   key2 = hi!

   [section1]
   key3 = salut   # end of line comment here

   [section2]
   key4  = hola   ; end of line comment here
   blank =
   blank2

   [section3 "http://example.com"]
   # comment here
   title  =  A rose is a rose is a rose, eh?
   ; another comment here
   title2 =  A rose is a rose is a rose, eh?
TXT

    hash = INI.load( text )

    exp = {"key1"=>"hello",
           "key2"=>"hi!",
           "section1"=>{"key3"=>"salut"},
           "section2"=>{"key4"=>"hola", "blank"=>"", "blank2"=>""},
           "section3"=>
           {"http://example.com"=>
            {"title"=>"A rose is a rose is a rose, eh?",
             "title2"=>"A rose is a rose is a rose, eh?"}}}

    assert_equal exp, hash

    assert_equal 'hello', hash['key1']
    assert_equal 'hi!',   hash['key2']
    assert_equal 'salut', hash['section1']['key3']
    assert_equal 'hola',  hash['section2']['key4']
    assert_equal '',      hash['section2']['blank']
    assert_equal '',      hash['section2']['blank2']
    assert_equal 'A rose is a rose is a rose, eh?', hash['section3']['http://example.com']['title']
    assert_equal 'A rose is a rose is a rose, eh?', hash['section3']['http://example.com']['title2']
  end

  def test_git
    text = <<TXT
    #
    # This is the config file, and
    # a '#' or ';' character indicates
    # a comment
    #

    ; core variables
    [core]
      ; Don't trust file modes
      filemode = false

    ; Our diff algorithm
    [diff]
      external = /usr/local/bin/diff-wrapper
      renames = true

    ; Proxy settings
    [core]
      gitproxy=proxy-command for kernel.org
      gitproxy=default-proxy ; for all the rest

    ; HTTP
    [http]
      sslVerify
    [http "https://weak.example.com"]
      sslVerify = false
      cookieFile = /tmp/cookie.txt
TXT

    hash = INI.load( text )

    exp = {"core"=>{"filemode"=>"false", "gitproxy"=>"default-proxy"},
           "diff"=>{"external"=>"/usr/local/bin/diff-wrapper", "renames"=>"true"},
           "http"=>
            {"sslVerify"=>"",
             "https://weak.example.com"=>
             {"sslVerify"=>"false", "cookieFile"=>"/tmp/cookie.txt"}}}

    assert_equal exp, hash

    assert_equal 'default-proxy', hash['core']['gitproxy']

    assert_equal '',      hash['http']['sslVerify']
    assert_equal 'false', hash['http']['https://weak.example.com']['sslVerify']
  end

  def test_planet
    text =<<TXT
    title = Planet Ruby

    [Ruby Lang News]
      feed = http://www.ruby-lang.org/en/feeds/news.rss

    [Rails Girls Summer of Code News]
      feed = https://railsgirlssummerofcode.org/blog.xml


    [Benoit Daloze]
      feed     = https://eregon.me/blog/feed.xml
      location = Zürich › Switzerland

    [Thomas Leitner]
      feed     = https://gettalong.org/posts.atom
      location = Vienna • Wien › Austria

    [Paweł Świątkowski]
      feed     = https://rubytuesday.katafrakt.me/feed.xml
      location = Kraków › Poland
TXT

    hash = INI.load( text )

    exp = {"title"=>"Planet Ruby",
           "Ruby Lang News"=>
            {"feed"=>"http://www.ruby-lang.org/en/feeds/news.rss"},
           "Rails Girls Summer of Code News"=>
            {"feed"=>"https://railsgirlssummerofcode.org/blog.xml"},
           "Benoit Daloze"=>
            {"feed"=>"https://eregon.me/blog/feed.xml",
             "location"=>"Zürich › Switzerland"},
           "Thomas Leitner"=>
            {"feed"=>"https://gettalong.org/posts.atom",
             "location"=>"Vienna • Wien › Austria"},
           "Paweł Świątkowski"=>
            {"feed"=>"https://rubytuesday.katafrakt.me/feed.xml",
             "location"=>"Kraków › Poland"}}

    assert_equal exp, hash

    assert_equal 'Kraków › Poland', hash['Paweł Świątkowski']['location']
  end

  def test_database
    text =<<TXT
    [database "development"]
    adapter  = sqlite3
    database = db/development.sqlite3

  [database "test"]
    adapter  = sqlite3
    database = db/test.sqlite3

  [database "production"]
    adapter  = sqlite3
    database = db/production.sqlite3
TXT

    hash = INI.load( text )

    exp = {"database"=>
            {"development"=>{"adapter"=>"sqlite3", "database"=>"db/development.sqlite3"},
             "test"=>{"adapter"=>"sqlite3", "database"=>"db/test.sqlite3"},
             "production"=>{"adapter"=>"sqlite3", "database"=>"db/production.sqlite3"}}}

    assert_equal exp, hash

    assert_equal 'db/development.sqlite3', hash['database']['development']['database']
    assert_equal 'db/test.sqlite3',        hash['database']['test']['database']
  end

  def test_windows
    text =<<TXT
    ; last modified 1 April 2001 by John Doe
    [owner]
    name=John Doe
    organization=Acme Widgets Inc.

    [database]
    ; use IP address in case network name resolution is not working
    server=192.0.2.62
    port=143
    file=payroll.dat
TXT

    hash = INI.load( text )

    exp = {"owner"=>{"name"=>"John Doe", "organization"=>"Acme Widgets Inc."},
           "database"=>{"server"=>"192.0.2.62", "port"=>"143", "file"=>"payroll.dat"}}

    assert_equal exp, hash

    assert_equal '192.0.2.62', hash['database']['server']
  end

  def test_quick
    ## from python's configparser
    text =<<TXT
  [DEFAULT]
  ServerAliveInterval = 45
  Compression = yes
  CompressionLevel = 9
  ForwardX11 = yes

  [bitbucket.org]
  User = hg

  [topsecret.server.com]
  Port = 50022
  ForwardX11 = no
TXT

    hash = INI.load( text )

    exp = {"DEFAULT"=>
            {"ServerAliveInterval"=>"45",
             "Compression"=>"yes",
             "CompressionLevel"=>"9",
             "ForwardX11"=>"yes"},
           "bitbucket.org"=>{"User"=>"hg"},
           "topsecret.server.com"=>{"Port"=>"50022", "ForwardX11"=>"no"}}

    assert_equal exp, hash

    assert_equal 'yes', hash['DEFAULT']['ForwardX11']
    assert_equal 'hg',  hash['bitbucket.org']['User']
    assert_equal 'no',  hash['topsecret.server.com']['ForwardX11']
  end

  def test_rosetta_stone
    text =<<TXT
    # This is a configuration file in standard configuration file format
    #
    # Lines beginning with a hash or a semicolon are ignored by the application
    # program. Blank lines are also ignored by the application program.

    # This is the fullname parameter
    FULLNAME Foo Barber

    # This is a favourite fruit
    FAVOURITEFRUIT banana

    # This is a boolean that should be set
    NEEDSPEELING

    # This boolean is commented out
    ; SEEDSREMOVED

    # Configuration option names are not case sensitive, but configuration parameter
    # data is case sensitive and may be preserved by the application program.

    # An optional equals sign can be used to separate configuration parameter data
    # from the option name. This is dropped by the parser.

    # A configuration option may take multiple parameters separated by commas.
    # Leading and trailing whitespace around parameter names and parameter data fields
    # are ignored by the application program.

    OTHERFAMILY Rhu Barber, Harry Barber
TXT

    hash = INI.load( text )

    exp = {"FULLNAME"=>"Foo Barber",
           "FAVOURITEFRUIT"=>"banana",
           "NEEDSPEELING"=>"",
           "OTHERFAMILY"=>"Rhu Barber, Harry Barber"}

    assert_equal exp, hash
  end
end  # class TestParser

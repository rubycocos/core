###
#  to run use
#     ruby -I ./lib test/test_unaccent.rb


require_relative  'helper'

class TestUnaccent < Minitest::Test

  def test_de
    assert_equal 'Augsburg',             unaccent( 'Augsburg' )

    assert_equal 'Koln',                 unaccent( 'Köln' )
    assert_equal '1. FC Koln',           unaccent( '1. FC Köln' )

    assert_equal 'Bayern Munchen',       unaccent( 'Bayern München' )
    assert_equal 'F. Dusseldorf',        unaccent( 'F. Düsseldorf' )
    assert_equal 'Preussen',             unaccent( 'Preußen' )
    assert_equal 'Munster Preussen',     unaccent( 'Münster Preußen' )
    assert_equal 'Rot-Weiss Oberhausen', unaccent( 'Rot-Weiß Oberhausen' )

    assert_equal 'St. Polten',           unaccent( 'St. Pölten' )
  end

  def test_es
    assert_equal 'Madrid',               unaccent( 'Madrid' )

    assert_equal 'Atletico Madrid',      unaccent( 'Atlético Madrid' )
    assert_equal 'Ecija Balompie',       unaccent( 'Écija Balompié' )
    assert_equal 'La Coruna',            unaccent( 'La Coruña' )
    assert_equal 'Almeria',              unaccent( 'Almería' )
  end


  def test_misc
     # serbian
     assert_equal 'Dorde Petrovic',   unaccent( 'Đorđe Petrović' )
     # slovak 
     assert_equal 'Lubomir Tupta',    unaccent( 'Ľubomír Tupta' )
  end
end # class TestUnaccent

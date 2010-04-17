require 'rubygems'
require 'textpow'
require 'test/unit'

class ScoreManagerTest < Test::Unit::TestCase
   include Textpow
   
   def test_score
      sp = ScoreManager.new
      reference_scope = 'text.html.basic source.php.embedded.html string.quoted.double.php'
      
      assert_not_equal( 0, sp.score( 'source.php string', reference_scope ) )
      assert_not_equal( 0, sp.score( 'text.html source.php', reference_scope ) )
      assert_equal( 0, sp.score( 'string source.php', reference_scope ) )
      assert_equal( 0, sp.score( 'source.php text.html', reference_scope ) )
      
      assert_equal( 0, sp.score( 'text.html source.php - string', reference_scope ) )
      assert_not_equal( 0, sp.score( 'text.html source.php - ruby', reference_scope ) )
      
      assert( sp.score( 'string', reference_scope ) > sp.score( 'source.php', reference_scope ) )
      assert( sp.score( 'string.quoted', reference_scope ) > sp.score( 'source.php', reference_scope ) )
      assert( sp.score( 'text source string', reference_scope ) > sp.score( 'source string', reference_scope ) )
   end
   
end

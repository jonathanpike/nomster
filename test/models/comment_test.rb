require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "humanized rating" do
    comment = FactoryGirl.create(:comment).humanized_rating 
    expected = "three stars"
    actual = comment
    assert_equal expected, actual
  end
end

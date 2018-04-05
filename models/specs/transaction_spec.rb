require("minitest/autorun")
require("minitest/rg")
require_relative('../transaction')
require_relative('../tagtype')
require_relative('../merchant')
require('date')

merchant1 = Merchant.new({
  "name" => "Tesco"
})

tagtype1 = TagType.new({
  "type" => "Food"
})

transaction1 = Transaction.new({
  "merchant_id" => merchant1.id,
  "value" => 67,
  "tagtype_id" => tagtype1.id,
  "date" => "2017-04-01"
})

class MoneyCashboardTest < MiniTest::Test

  def setup
    @merchant1 = Merchant.new({
      "name" => "Tesco"
    })
    @tagtype1 = TagType.new({
      "type" => "Food"
    })
    @transaction1 = Transaction.new({
      "merchant_id" => @merchant1.id,
      "value" => 67,
      "tagtype_id" => @tagtype1.id,
      "date" => "2017-04-01"
    })
  end


  def test_merchant_initialize
    assert_equal("Tesco", @merchant1.name)
  end

  def test_tagtype_initialize
    assert_equal("Food", @tagtype1.type)
  end

  def test_transaction_initialize
    assert_equal(@merchant1.id, @transaction1.merchant_id)
    assert_equal(67, @transaction1.value)
    assert_equal(@tagtype1.id, @transaction1.tagtype_id)
    assert_equal("2017-04-01", @transaction1.date)
  end

end

require_relative('../models/transaction')
require_relative('../models/tagtype')
require_relative('../models/merchant')

Transaction.delete_all()
TagType.delete_all()
Merchant.delete_all()

merchant1 = Merchant.new({
  "name" => "Tesco"
})

merchant2 = Merchant.new({
  "name" => "Primark"
})

merchant3 = Merchant.new({
  "name" => "John Lewis"
})

merchant4 = Merchant.new({
  "name" => "Argos"
})

merchant5 = Merchant.new({
  "name" => "Dunelm"
})

merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()
merchant5.save()

tagtype1 = TagType.new({
  "type" => "Food"
})

tagtype2 = TagType.new({
  "type" => "Clothes"
})

tagtype3 = TagType.new({
  "type" => "Music/DVDs"
})

tagtype4 = TagType.new({
  "type" => "Furniture"
})

tagtype5 = TagType.new({
  "type" => "Electrical Goods"
})

tagtype1.save()
tagtype2.save()
tagtype3.save()
tagtype4.save()
tagtype5.save()

transaction1 = Transaction.new({
  "merchant_id" => merchant1.id,
  "value" => 67,
  "tagtype_id" => tagtype1.id
})

transaction2 = Transaction.new({
  "merchant_id" => merchant2.id,
  "value" => 159,
  "tagtype_id" => tagtype2.id
})

transaction1.save()
transaction2.save()

p transaction1
p transaction2

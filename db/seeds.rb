require_relative('../models/transaction')
require_relative('../models/tag')

Transaction.delete_all()
Tag.delete_all()

tag1 = Tag.new({
  "type" => "Food"
})

tag2 = Tag.new({
  "type" => "Clothes"
})

tag1.save()
tag2.save()

p tag1
p tag2

transaction1 = Transaction.new({
  "merchant_name" => "Tesco",
  "value" => 67,
  "tag_id" => tag1.id
})

transaction2 = Transaction.new({
  "merchant_name" => "John Lewis",
  "value" => 159,
  "tag_id" => tag2.id
})

p transaction1
p transaction2

transaction1.save()
transaction2.save()

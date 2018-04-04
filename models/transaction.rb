require_relative('../db/sql_runner')
require('date')

class Transaction
  attr_reader :id
  attr_accessor :merchant_id, :value, :tagtype_id, :date

  def initialize(transaction)
    @id = transaction['id'].to_i
    @merchant_id = transaction['merchant_id'].to_i
    @value = transaction['value'].to_i
    @tagtype_id = transaction['tagtype_id'].to_i
    @date = transaction['date']
  end

  def save
    sql = "INSERT INTO transactions (merchant_id, value, tagtype_id, date)
    VALUES ($1, $2, $3, $4)
    RETURNING id;"
    values = [@merchant_id, @value, @tagtype_id, @date]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def self.all
    sql = "SELECT * FROM transactions"
    transactions_hash = SqlRunner.run(sql)
    transactions = transactions_hash.map{|transaction| Transaction.new(transaction)}
    return transactions
  end

  def self.find( id )
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )
    transaction = Transaction.new( result.first )
    return transaction
  end

  def update()
    sql = "UPDATE transactions
    SET (merchant_id, value, tagtype_id, date) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@merchant_id, @value, @tagtype_id, @date, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql)
  end

  def self.get_total_value()
    transactions = Transaction.all()
    total_value = 0
    transactions.each {|transaction| total_value += transaction.value}
    return total_value
  end

  def self.get_total_values_by_tag()
    transactions = Transaction.all()
    tags = TagType.all()
    total_values_by_tag_array = []

    tags.each do |tag|
      tag_running_total = 0

      transactions.each do |transaction|
        transaction_tag = TagType.find(transaction.tagtype_id)
        if transaction_tag.type == tag.type
          tag_running_total += transaction.value
        end
      end

      tag_total_hash = {"tag_type" => tag.type, "total" => tag_running_total}
      total_values_by_tag_array.push(tag_total_hash)
    end

    return total_values_by_tag_array
  end

  def self.get_spending_by_month()

    transactions = Transaction.all()
    month_totals = Array.new(12,0)

      transactions.each do |transaction|
        transaction_month = transaction.date.slice(5,2).to_i - 1
        month_totals[transaction_month] += transaction.value
      end

    return month_totals
  end


end

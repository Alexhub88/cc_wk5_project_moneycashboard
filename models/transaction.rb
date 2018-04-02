require_relative('../db/sql_runner')

class Transaction
  attr_reader :id
  attr_accessor :merchant_name, :value, :tag_id

  def initialize(transaction)
    @id = transaction['id'].to_i
    @merchant_name = transaction['merchant_name']
    @value = transaction['value'].to_i
    @tag_id = transaction['tag_id'].to_i
  end

  def save
    sql = "INSERT INTO transactions (merchant_name, value, tag_id)
    VALUES ($1, $2, $3)
    RETURNING id;"
    values = [@merchant_name, @value, @tag_id]
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
    SET (merchant_name, value) = ($1, $2)
    WHERE id = $3"
    values = [@merchant_name, @value, @id]
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

end

require_relative('../db/sql_runner')

class Tag
  attr_reader :id
  attr_accessor :type

  def initialize(tag)
    @id = tag['id'].to_i
    @type = tag['type']
  end

  def save
    sql = "INSERT INTO tags (type)
    VALUES ($1)
    RETURNING id;"
    values = [@type]
    @id = SqlRunner.run(sql, values).first["id"].to_i
  end

  def self.all
    sql = "SELECT * FROM tags"
    tags_hash = SqlRunner.run(sql)
    tags = tags_hash.map{|tag| Tag.new(tag)}
    return tags
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    tags_hash = SqlRunner.run(sql)
    tags = tags_hash.map{|tag| Tag.new(tag)}
    return tags
  end

  def update()
    sql = "UPDATE tags
    SET (type) = ($1)
    WHERE id = $1"
    values = [@type, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run( sql)
  end

end

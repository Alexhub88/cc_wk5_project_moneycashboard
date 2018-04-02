DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tags;


CREATE TABLE tags(
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255)
);

CREATE TABLE transactions(
  id SERIAL4 PRIMARY KEY,
  merchant_name VARCHAR(255),
  value INT4,
  tag_id INT4 REFERENCES tags(id) ON DELETE CASCADE
);
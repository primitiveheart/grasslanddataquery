CREATE TABLE IF NOT EXISTS users(
  id int(11) PRIMARY KEY auto_increment,
  username VARCHAR(30) NOT NULL ,
  password VARCHAR(20) NOT NULL ,
  user_type VARCHAR(10) NOT null,
  extras VARCHAR(200)
);

DROP TABLE IF EXISTS applydatas;
CREATE TABLE IF NOT EXISTS applydatas(
  id int(11) PRIMARY KEY auto_increment,
  coordinate VARCHAR(100) NOT NULL ,
  data_type VARCHAR(500) NOT NULL ,
  start_time VARCHAR(10) NOT NULL ,
  end_time VARCHAR(10) NOT NULL ,
  create_time TIMESTAMP NOT NULL ,
  update_time TIMESTAMP ,
  status VARCHAR(10) DEFAULT '审核中',
  userId int(11),
  FOREIGN KEY(userId) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS services(
  id int(11) PRIMARY KEY auto_increment,
  big_data_type VARCHAR(50) NOT  NULL,
  small_data_type VARCHAR(50) NOT NULL,
  year_ int(5) NOT NULL ,
  layer VARCHAR(40) NOT NULL ,
  create_time TIMESTAMP ,
  update_time TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bigdatatypes(
  id int(11) PRIMARY KEY auto_increment,
  data_type VARCHAR(50),
  data_type_english VARCHAR(50)
);
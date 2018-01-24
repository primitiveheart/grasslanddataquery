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
  status VARCHAR(10) DEFAULT '审核中',
  userId int(11),
  FOREIGN KEY(userId) REFERENCES users(id)
);
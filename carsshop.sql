delimiter |
-- drop database carsshop; |

create database carsshop; |

use carsshop; |


create table marks(
   id int not null auto_increment primary key,
   mark varchar(20) unique
); |

create table cars(
  id INT NOT NULL auto_increment primary key,
  mark_id INT NOT NULL,
  model varchar(20) NOT NULL,
  price INT NOT NULL,
  foreign key(mark_id) references marks(id)
); |

CREATE TABLE clients
(
	
	 id INT AUTO_INCREMENT NOT NULL,
     name VARCHAR(30),
     age TINYINT,
     phone VARCHAR(15),
     PRIMARY KEY (id)
); |

create table orders(
     id int not null primary key auto_increment,
     car_id int not null,
     client_id int not null,
     foreign key(car_id) references cars(id),
     foreign key(client_id) references clients(id)
); |

INSERT into marks(mark) values('Audi');|
INSERT into marks(mark) values('Porsche'); |

insert into cars(mark_id, model, price) values (1, 'A5', 50000); |
insert into cars(mark_id, model, price) values (2, 'panamera', 100000); |
insert into cars(mark_id, model, price) values (2, 'caymen S', 88000); |

insert into clients(name, age) values ('petro', 20), ('vasya', 25), ('vitaly', 75); |

insert into orders(car_id, client_id) values(1, 1), (2, 2), (1, 3); |

-- Используя базу данных carsshop создайте функцию для нахождения минимального возраста клиента, затем сделайте выборку всех машин, которые он купил.
DELIMiTER |
CREATE PROCEDURE find_min_age_customer()
BEGIN
    SELECT cl.age, m.mark
FROM clients cl
LEFT JOIN orders o ON cl.id = o.client_id
LEFT JOIN cars c ON c.id = o.car_id
LEFT JOIN marks m ON m.id = c.mark_id
order by cl.age asc
limit 1;
END
|
CALL find_min_age_customer (); |
DROP PROCEDURE find_min_age_customer; |

-- Другий варіант
CREATE PROCEDURE find_min_age_customer_v2()
BEGIN
    SELECT MIN(age) FROM clients;
END |

CALL find_min_age_customer_v2();
Drop PROCEDURE find_min_age_customer_v2; |

SELECT * FROM cars
INNER JOIN orders ON cars.id = orders.car_id
WHERE orders.client_id IN (
    SELECT id FROM clients WHERE age = (SELECT MIN(age) FROM clients)
);



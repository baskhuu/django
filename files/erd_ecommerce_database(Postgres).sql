CREATE DATABASE ecommerce; 

DROP TABLE IF EXISTS user_review; 

DROP TABLE IF EXISTS order_line; 

DROP TABLE IF EXISTS shop_order; 

DROP TABLE IF EXISTS order_status; 

DROP TABLE IF EXISTS shipping_method; 

DROP TABLE IF EXISTS shopping_cart_item; 

DROP TABLE IF EXISTS shopping_cart; 

DROP TABLE IF EXISTS user_payment_method; 

DROP TABLE IF EXISTS payment_type; 

DROP TABLE IF EXISTS product_configuration; 

DROP TABLE IF EXISTS variation_option; 

DROP TABLE IF EXISTS variation; 

DROP TABLE IF EXISTS product_item; 

DROP TABLE IF EXISTS product; 

DROP TABLE IF EXISTS promotion_category; 

DROP TABLE IF EXISTS promotion; 

DROP TABLE IF EXISTS product_category; 

DROP TABLE IF EXISTS user_address; 

DROP TABLE IF EXISTS site_user; 

DROP TABLE IF EXISTS address; 

DROP TABLE IF EXISTS country; 

CREATE TABLE country( 
    id SERIAL PRIMARY KEY
    , country_name VARCHAR (500)
); 

CREATE TABLE address( 
    id SERIAL PRIMARY KEY
    , unit_number VARCHAR (20)
    , street_number VARCHAR (20)
    , address_line1 VARCHAR (500)
    , address_line2 VARCHAR (500)
    , city VARCHAR (200)
    , region VARCHAR (200)
    , postal_code VARCHAR (20)
    , country_id INT
    , FOREIGN KEY (country_id) REFERENCES country(id)
); 

CREATE TABLE site_user( 
    id SERIAL PRIMARY KEY
    , email_address VARCHAR (350)
    , phone_number VARCHAR (20)
    , password VARCHAR (500)
); 

CREATE TABLE user_address( 
    user_id INT
    , address_id INT
    , is_default INT
    , FOREIGN KEY (user_id) REFERENCES site_user(id)
    , FOREIGN KEY (address_id) REFERENCES address(id)
); 

CREATE TABLE product_category( 
    id SERIAL PRIMARY KEY
    , parent_category_id INT
    , category_name VARCHAR (200)
    , FOREIGN KEY (parent_category_id) REFERENCES product_category(id)
); 

CREATE TABLE promotion( 
    id SERIAL PRIMARY KEY
    , name VARCHAR (200)
    , description VARCHAR (2000)
    , discount_rate INT
    , start_date TIMESTAMP
    , end_date TIMESTAMP
); 

CREATE TABLE promotion_category( 
    category_id INT
    , promotion_id INT
    , FOREIGN KEY (category_id) REFERENCES product_category(id)
    , FOREIGN KEY (promotion_id) REFERENCES promotion(id)
); 

CREATE TABLE product( 
    id SERIAL PRIMARY KEY
    , category_id INT
    , name VARCHAR (500)
    , description VARCHAR (4000)
    , product_image VARCHAR (1000)
); 

CREATE TABLE product_item( 
    id SERIAL PRIMARY KEY
    , product_id INT
    , sku VARCHAR (20)
    , qty_in_stock INT
    , product_image VARCHAR (1000)
    , price INT
    , FOREIGN KEY (product_id) REFERENCES product(id)
); 

CREATE TABLE variation( 
    id SERIAL PRIMARY KEY
    , category_id INT
    , name VARCHAR (500)
    , FOREIGN KEY (category_id) REFERENCES product_category(id)
); 

CREATE TABLE variation_option( 
    id SERIAL PRIMARY KEY
    , variation_id INT
    , value VARCHAR (200)
    , FOREIGN KEY (variation_id) REFERENCES variation(id)
); 

CREATE TABLE product_configuration( 
    product_item_id INT
    , variation_option_id INT
    , FOREIGN KEY (product_item_id) REFERENCES product_item(id)
    , FOREIGN KEY (variation_option_id) REFERENCES variation_option(id)
); 

CREATE TABLE payment_type( 
    id SERIAL PRIMARY KEY
    , value VARCHAR (100)
); 

CREATE TABLE user_payment_method( 
    id SERIAL PRIMARY KEY
    , user_id INT
    , payment_type_id INT
    , provider VARCHAR (100)
    , account_number VARCHAR (50)
    , expiry_date DATE
    , is_default INT
    , FOREIGN KEY (user_id) REFERENCES site_user(id)
    , FOREIGN KEY (payment_type_id) REFERENCES payment_type(id)
); 

CREATE TABLE shopping_cart( 
    id SERIAL PRIMARY KEY
    , user_id INT
    , FOREIGN KEY (user_id) REFERENCES site_user(id)
); 

CREATE TABLE shopping_cart_item( 
    id SERIAL PRIMARY KEY
    , cart_id INT
    , product_item_id INT
    , qty INT
    , FOREIGN KEY (cart_id) REFERENCES shopping_cart(id)
    , FOREIGN KEY (product_item_id) REFERENCES product_item(id)
); 

CREATE TABLE shipping_method( 
    id SERIAL PRIMARY KEY
    , name VARCHAR (100)
    , price INT
); 

CREATE TABLE order_status( 
    id SERIAL PRIMARY KEY
    , status VARCHAR (100)
); 

CREATE TABLE shop_order( 
    id SERIAL PRIMARY KEY
    , user_id INT
    , order_date TIMESTAMP
    , payment_method_id INT
    , shipping_address INT
    , shipping_method INT
    , order_total INT
    , order_status INT
    , FOREIGN KEY (user_id) REFERENCES site_user(id)
    , FOREIGN KEY (payment_method_id) REFERENCES user_payment_method(id)
    , FOREIGN KEY (shipping_address) REFERENCES address(id)
    , FOREIGN KEY (shipping_method) REFERENCES shipping_method(id)
    , FOREIGN KEY (order_status) REFERENCES order_status(id)
); 

CREATE TABLE order_line( 
    id SERIAL PRIMARY KEY
    , product_item_id INT
    , order_id INT
    , qty INT
    , price INT
    , FOREIGN KEY (product_item_id) REFERENCES product_item(id)
    , FOREIGN KEY (order_id) REFERENCES shop_order(id)
); 

CREATE TABLE user_review( 
    id SERIAL PRIMARY KEY
    , user_id INT
    , ordered_product_id INT
    , rating_value INT
    , comment VARCHAR (2000)
    , FOREIGN KEY (user_id) REFERENCES site_user(id)
    , FOREIGN KEY (ordered_product_id) REFERENCES order_line(id)
);

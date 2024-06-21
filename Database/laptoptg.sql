CREATE DATABASE  IF NOT EXISTS `laptop_tg` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laptop_tg`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: laptop_tg
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (2,'Apple'),(3,'Asus'),(4,'Acer'),(5,'Dell'),(6,'HP'),(7,'Lenovo'),(8,'MSI'),(9,'Masstel'),(10,'Haier');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKUser_Cart` (`user_id`),
  CONSTRAINT `FKUser_Cart` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (2,1),(1,2),(3,23),(4,27);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_details`
--

DROP TABLE IF EXISTS `cart_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCart_CartDetails` (`cart_id`),
  KEY `FKProduct_CartDetails` (`product_id`),
  CONSTRAINT `FKCart_CartDetails` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKProduct_CartDetails` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_details`
--

LOCK TABLES `cart_details` WRITE;
/*!40000 ALTER TABLE `cart_details` DISABLE KEYS */;
INSERT INTO `cart_details` VALUES (15,1,2,88),(16,1,2,85),(64,1,3,6);
/*!40000 ALTER TABLE `cart_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Laptop'),(2,'PC đồng bộ'),(3,'Thiết bị nghe nhìn'),(4,'Linh kiện máy tính'),(5,'Thiết bị lưu trữ'),(6,'Thiết bị mạng'),(7,'Camera'),(8,'Phụ kiện'),(9,'Thiết bị văn phòng');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `unit_price` bigint NOT NULL,
  `quantity` int NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `maintenance` varchar(255) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `rated_status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKOrder_OrderDetails` (`order_id`),
  KEY `FKProduct_OrderDetails` (`product_id`),
  CONSTRAINT `FKOrders_OrderDetails` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKProduct_OrderDetails` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (1,13980000,2,32,62,'MSI GF63 8RC-203VN/I5-8300H','6 tháng','62.png',0),(2,25990000,1,31,57,'MSI GF63 8RD-218VN/i7-8750H','12 tháng','57.png',0),(3,22490000,1,32,54,'Masstel L133 Pro/Celeron N4100','12 tháng','54.png',1),(5,29000000,1,34,7,'Macbook Pro 13 Touch Bar 256 GB (2018)','12 tháng','7.png',1),(6,123,1,35,NULL,'afddasfsa','','144.png',0),(7,16199000,1,36,NULL,'Macbook 12 256GB (2017)','12 tháng','5.png',0),(10,26530000,1,39,6,'Macbook Pro 13 inch 128GB (2017)','12 tháng','6.png',0),(12,100000,1,41,107,'Mouse ASUS ROG Gladius II','2 tháng','107.png',0),(13,1200000,1,42,106,'Mouse ASUS ROG Strix Impact','2 tháng','106.png',0),(14,1200000,1,43,106,'Mouse ASUS ROG Strix Impact','2 tháng','106.png',0),(15,3200000,1,44,90,'Tai nghe ASUS ROG Strix Fusion Wireless','6 tháng','90.png',0),(17,3200000,1,46,93,'Tai nghe Asus Centurion - ROG Gaming Headset','6 tháng','93.png',0),(18,300000,1,47,103,'Bàn Phím Asus ROG Claymore Ultimate RGB Aura Sync Cherry Red switch','6 tháng','103.png',0),(19,300000,1,48,103,'Bàn Phím Asus ROG Claymore Ultimate RGB Aura Sync Cherry Red switch','6 tháng','103.png',0);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `deliver_date` datetime DEFAULT NULL,
  `receive_date` datetime DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `saler_id` bigint DEFAULT NULL,
  `payment_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKPayment_Order` (`payment_id`),
  KEY `FKUser_Order` (`user_id`),
  KEY `FKSaler_Order` (`saler_id`),
  CONSTRAINT `FKPayment_Order` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKSaler_Order` FOREIGN KEY (`saler_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FKUser_Order` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (31,'bd','asdf','aaa','2018-12-01 14:38:26','2024-06-19 00:00:00',NULL,'dsf','received',2,3,5),(32,'fadf','asdf','aaa','2018-12-05 21:58:24',NULL,NULL,'13','received',2,NULL,3),(34,'Hà Nội 2','','Tạ Minh Đăng','2024-06-19 08:48:44',NULL,NULL,'0366556380','received',27,3,33),(35,'Hà Nội 2','','Tạ Minh Đăng','2024-06-19 09:11:34',NULL,NULL,'0366556380','processing',27,3,34),(36,'Hà Nội 2','','Tạ Minh Đăng','2024-06-19 09:15:21',NULL,NULL,'0366556380','processing',27,3,35),(39,'Hà Nội','','Nombre Noir','2024-06-19 18:14:28',NULL,NULL,'0366556380','pending',2,NULL,38),(41,'Hà Nội','','Tạ Minh Đăng','2024-06-19 18:37:16',NULL,NULL,'0366556380','pending',27,NULL,40),(42,'Hà Nội','','Tạ Minh Đăng','2024-06-19 18:38:35',NULL,NULL,'0366556380','cancelled',27,NULL,41),(43,'Hà Nội','','Tạ Minh Đăng','2024-06-19 18:38:36',NULL,NULL,'0366556380','pending',27,NULL,42),(44,'Hà Nội','','Tạ Minh Đăng','2024-06-19 21:24:37',NULL,NULL,'0366556380','pending',27,NULL,43),(46,'Hòa Lạc','','Nombre Noir','2024-06-20 20:39:24',NULL,NULL,'0123456789','pending',2,NULL,45),(47,'Hòa Lạc','fasdjfhashlfas','Tạ Minh Đăng','2024-06-21 11:36:22',NULL,NULL,'0123456789','cancelled',27,NULL,46),(48,'Hanoi','fadfdas','Tạ Minh Đăng','2024-06-21 11:37:14',NULL,NULL,'0123456789','pending',27,NULL,47);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_method` varchar(255) NOT NULL,
  `amount` bigint NOT NULL,
  `payment_status` varchar(255) NOT NULL,
  `payment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (3,'cod',53950000,'unpaid',NULL),(5,'online',25990000,'unpaid',NULL),(33,'cod',29000000,'unpaid',NULL),(34,'cod',123,'unpaid',NULL),(35,'cod',16199000,'unpaid',NULL),(38,'online',26530000,'paid','2024-06-19 18:14:56'),(40,'online',100000,'paid','2024-06-19 21:34:34'),(41,'online',1200000,'unpaid',NULL),(42,'online',1200000,'paid','2024-06-19 18:39:54'),(43,'online',3200000,'paid','2024-06-19 21:25:23'),(45,'online',3200000,'paid','2024-06-20 20:39:56'),(46,'online',300000,'unpaid',NULL),(47,'online',300000,'paid','2024-06-21 11:38:17');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cpu` varchar(255) DEFAULT NULL,
  `unit_price` bigint NOT NULL,
  `sold_unit` int NOT NULL,
  `stock_unit` int NOT NULL,
  `battery_vol` varchar(255) DEFAULT NULL,
  `operating_system` varchar(255) DEFAULT NULL,
  `monitor_scale` varchar(255) DEFAULT NULL,
  `ram` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `design` varchar(255) DEFAULT NULL,
  `maintenance` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `brand_id` bigint DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCategory_Product` (`category_id`),
  KEY `FKBrand_Product` (`brand_id`),
  CONSTRAINT `FKBrand_Product` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKCategory_Product` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (3,'Intel, Core i5, 1.8 Ghz',18199000,0,0,'5800mAh',' Mac Os',' 13.3 inch LED-backlit','8 GB, LPDDR3, 1600 Mhz','Macbook Air 13 128GB MQD32SA/A (2017)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2,'3.png','active'),(4,' Intel, Core i5, 1.8 Ghz',21490000,0,100,'6000mAh','Mac Os','13.3 inch LED-backlit',' 8 GB, LPDDR3, 1600 Mhz','Macbook Air 13 256GB MQD42SA/A (2017)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2,'4.png','active'),(6,' Intel, Core i5, 2.3 GHz',26530000,0,200,'6000mAh','Mac Os',' 13.3 inch LED-backlit',' 8 GB, LPDDR3, 2133MHz','Macbook Pro 13 inch 128GB (2017)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2,'6.png','active'),(7,'Intel, Core i5, 2.3GHz',29000000,0,100,'7000mAh','Mac Os','13.3 inch, Retina (2560 x 1600 pixels)','8 GB, LPDDR3, 2133 MHz','Macbook Pro 13 Touch Bar 256 GB (2018)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2,'7.png','active'),(8,'Intel, Core i5, 2.3GHz',27490000,0,150,'7000mAh','Mac Os','13.3 inch, Retina (2560 x 1600 pixels)','8 GB, LPDDR3, 2133 MHz','Macbook Pro 13 Touch Bar 512 GB (2018)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2,'8.png','active'),(9,'Intel, Core i7, 2.2GHz',31190000,0,200,'7000mAh','Mac Os','15.4 inch, Retina (2880 x 1800 pix','16GB, LPDDR4, 2400MHz','Macbook Pro 15 Touch Bar 256 GB (2018)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2,'9.png','active'),(10,'Intel, Core i7, 2.2GHz',24000000,0,120,'7000mAh','Mac Os','15.4 inch, Retina (2880 x 1800 pi','16GB, LPDDR4, 2400MHz','Macbook Pro 15 Touch Bar 512 GB (2018)','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','hiệu năng được nâng cấp, thời lượng pin cực lâu, phù hợp cho nhu cầu làm việc văn phòng nhẹ nhàng, không cần quá chú trọng vào hiển thị của màn hình',1,2,'10.png','active'),(11,' Intel Celeron N3350',17500000,0,100,'7000','Windows 10','14 inch HD LED Glare',' 4 GB DDR3','Asus E402NA-GA034T','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Bàn phím chiclet cùng Touchpad thông minh',1,3,'11.png','active'),(12,'Intel Celeron N3060',14990000,0,200,'7000','Windows 10','14.0 inch HD Ultra Slim 200nits','2 GB DDR3L 1600 MHz','Asus Vivobook E406SA-BV001T','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Bàn phím chiclet cùng Touchpad thông minh',1,3,'12.png','active'),(13,'Intel Celeron N3060',18290000,0,200,'7000','Windows 10','14.0 inch HD Ultra Slim 200nits','2 GB DDR3 1600 MHz','Asus Vivobook E406SA-BV043T','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','gọn,nhẹ, độ bền cao',1,3,'13.png','active'),(14,'Intel Celeron N4000',17000000,0,120,'7000',' Windows 10','15.6 inch Anti-Glare LED Backlit',' 4 GB DDR4 2400 MHz','Asus Vivobook X507MA-BR208T/Celeron N4000','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,3,'14.png','active'),(15,'Intel Pentium N4200',19990000,0,110,'6000','Windows 10','15.6 inch HD LED',' 4 GB, DDR3L, 1600 MHz','Asus X541NA-GO012T/Pentium N4200','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,3,'15.png','active'),(16,'Intel, Core i3-6100U',18990000,0,130,'7000','Windows 10 Home','15.6 inch LED Backlight','4 GB DDR4 2133 MHz','Asus X541UA-XX272T/Core i3 6100U','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,3,'16.png','active'),(17,' Intel, Core i3, 2.0 GHz',15460000,0,200,'7000',' Free DOS','15.6 inchHD LED backlight','4 GB, DDR4, 2400MHz','Asus X541UA-GO1345','thiết kế với lớp vỏ bằng nhựa giúp cho máy trở nên nhẹ nhàng hơn','12 tháng','tinh tế đến từng chi tiết',1,3,'17.png','active'),(18,' Intel, Core i3, 2.0 GHz',17290000,0,300,'7000','Window 10',' 15.6 inchLED Backlight',' 4 GB, DDR4, 2400MHz','Asus X541UJ-DM544T/Core i3-6006U','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,3,'18.png','active'),(19,' Intel, Celeron, 1.10 GHz',13500000,0,300,'7000',' Linux','5.6 inchAcer CineCrystal LED',' 4 GB DDR3L 1333 MHz','Acer AS A315-31-C8GB','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4,'19.png','active'),(20,' Intel Celeron N4000',15500000,0,100,'8000','Linux',' 15.6 inchs HD LED Backlight','4 GB DDR4 2133 MHz','Acer A315-32-C9A4 ','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4,'20.png','active'),(21,' Intel Core i3-7020U',19500000,0,100,'8000',' Linux','14.0 inchs HD LED','4 GB DDR4 2400 MHz','Acer E5-476-33BQ','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4,'21.png','active'),(22,' Intel Core i3-6006U',18890000,0,50,'5000','Linux','15.6 inch HD',' 4 GB DDR4 2133MHz','Acer A315-51-3932/Core i3-6006U','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4,'22.png','active'),(23,'Intel Core i3-7020U',12990000,0,300,'6000','Linux','15.6 inchs HD LED Backlight','4 GB DDR4 2133 MHz','Acer AS A315-51-325E','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4,'23.png','active'),(24,' Intel Core i3',11500000,0,130,'5000','Linux','15.6 inch  HD',' 4 GB DDR4 2133 MHz','Acer A315-51-364W','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4,'24.png','active'),(25,' Intel, Core i3, 2.4 Ghz',10690000,0,120,'5000','Free DOS',' 15.6 inchFull HD',' 4 GB, DDR4, 2133 MHz','Acer Aspire E5-575G-39QW','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4,'25.png','active'),(26,' Intel Core i5-8250U',16990000,0,130,'6000',' Windows 10 Home','14.0 inchs FHD IPS LCD',' 4 GB DDR4 2133 MHz','Acer Swift SF314-52-55UF','thiết kế không thay đổi, vỏ nhôm sang trọng, siêu mỏng và siêu nhẹ','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,4,'26.png','active'),(27,' Intel Pentium N3710',9500000,0,110,'5000',' Ubuntu','15.6 inchs HD Truelife',' 4 GB DDR3 1600 MHz','Dell Inspiron N3552','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5,'27.png','active'),(28,' Intel Pentium N3710',9990000,0,100,'5000','Ubuntu','15.6 inchs HD Truelife',' 4 GB DDR3 1600 MHz','Dell Inspiron N3567C','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5,'28.png','active'),(29,'Intel, Core i3, 2.0 GHz',10500000,0,100,'6000','Ubuntu 16.04','14 inchHD Anti-Glare LED','4 GB, DDR4, 2400MHz','Dell Inspiron N3467','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5,'29.png','active'),(30,' Intel Core i3-6006U',10890000,0,120,'7000','Linux','15.6 inchs',' 4 GB DDR4 2400 MHz','Dell Vostro 3568','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5,'30.png','active'),(31,' Intel, Core i3, 2.0 GHz',11190000,0,90,'6000',' Free DOS',' 15.6 inchHD LED',' 4 GB, DDR3L, 1600 Mhz','Dell Ins N3567','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5,'31.png','active'),(32,' Intel Core i3-7020U',11590000,0,80,'7000',' Ubuntu','15.6 inch HD Anti Glare LED','4 GB DDR4 2400 MHz','Dell Inspiron N3576','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5,'32.png','active'),(33,'Intel Core i3-7020U',11890000,0,110,'8000',' Windows 10 Home','15.6 inches Anti-Glare LED',' 4 GB DDR4 2400 MHz','Dell Vostro 3568','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5,'33.png','active'),(34,' Intel, Core i3, 2.40 GHz',12490000,0,100,'8000','Free DOS','14 inchHD Anti-Glare LED','4 GB, DDR4, 2133 MHz','Dell Vostro V5468/i3','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,5,'34.png','active'),(35,' Intel Celeron',8990000,0,100,'5000','Linux',' 15.6 inchs',' 4 GB DDR3L 1600 MHz','HP 15-bs644TU/Celeron-N3060','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6,'35.png','active'),(36,' Intel Celeron N4000',6190000,0,70,'7000',' Windows 10 Home',' 15.6 inchs HD HD SVA ',' 4 GB DDR4 2400 MHz','HP 15-da0107TU/Celeron','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6,'36.png','active'),(37,' Intel Penitum N3710',6990000,0,120,'8000','Windows 10','15.6 inch',' 4GB DDR4','HP 15-bs648TU','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6,'37.png','active'),(38,' Intel, Core i3, 2.0 GHz',8990000,0,80,'8000',' Free Dos','15.6 inch LED-backlit',' 4GB, DDR4, 2133 MHz','HP 15-bs555TU','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6,'38.png','active'),(39,' Intel, Core i3, 2.0 GHz',10490000,0,90,'7000',' Free DOS',' 15.6 inchHD SVA BrightView',' 4 GB, DDR4, 2133 MHz','HP 15-bs637TX','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6,'39.png','active'),(40,' Intel Core i3-7100U',11490000,0,90,'6000',' Free DOS',' 15.6 inch',' 4GB DDR4','HP Pavilion 15-cc043TU','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6,'40.png','active'),(41,' Intel, Core i5, 2.50 GHz',12190000,0,100,'8000','Free DOS','15.6 inchHD SVA BrightView',' 4 GB, DDR4, 2133 MHz','HP 15-bs559TU','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6,'41.png','active'),(42,' Intel Core i3-7100U',12990000,0,150,'7000','Windows 10 Home Single',' 11.6 inch HD',' 4 GB DDR4 2133 MHz','HP Pavilion X360 11','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,6,'42.png','active'),(43,'Intel, Celeron, 1.10 GHz',4990000,0,100,'6000',' Windows 10 EM',' 11.6 inchHD LED',' 2 GB, LPDDR4, 2400MHz','Lenovo Ideapad 120S-11IAP','Thiết kế gọn gàng để di chuyển','6 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7,'43.png','active'),(44,' Intel, Pentium, 1.60 GHz',5490000,0,120,'5000',' Free DOS','14 inchHD LED backlight',' 4 GB, DDR3L, 1600 MHz','Lenovo IdeaPad 110','Thiết kế gọn gàng để di chuyển','6 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7,'44.png','active'),(45,' Intel, Pentium, 1.10 GHz',7490000,0,80,'7000',' Windows 10',' 11.6 inchHD TN AG TOUCH',' 4 GB, DDR3L, 1600 MHz','Lenovo Yoga 310-11IAP','Thiết kế gọn gàng để di chuyển','6 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7,'45.png','active'),(46,'Intel Core i3-6006U',8990000,0,120,'7000','FreeDOS',' 14.0 inchs HD LED',' 4 GB DDR4 2133 MHz','Lenovo Ideapad 320-14ISK ','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7,'46.png','active'),(47,'Intel Core i5-8250U',10990000,0,130,'5000',' Windows 10 Home',' 14.0 inchs HD LED','4 GB DDR4 2133 MHz','Lenovo Ideapad 330-14IKBR','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7,'47.png','active'),(48,' Intel, Core i5, 2.50 GHz',11290000,0,120,'5000','Linux',' 15.6 inchFull HD',' 4 GB, DDR4, 2133 MHz','Lenovo IdeaPad 310-15IKB','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7,'48.png','active'),(49,' Intel Core i5-8250U',13490000,0,130,'6000','Linux',' 14.0 inchs FHD IPS','4 GB DDR4 2400 MHz','Lenovo Ideapad 330S-14IKBR','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7,'49.png','active'),(50,' Intel, Core i5, 2.50 GHz',15990000,0,200,'7000','Windows 10 Single',' 15.6 inchAnti-Glare LED',' 4 GB, DDR4, 2133 MHz','Lenovo ThinkPad E570','Thiết kế gọn gàng để di chuyển','12 tháng','Thiết kế hoàn mỹ tinh tế và sang trọng',1,7,'50.png','active'),(51,' Intel, Core i5, 2.50 GHz',18990000,0,300,'7000',' Free DOS',' 15.6 inchWide-View','4 GB, DDR4, 2133 MHz','MSI GL62M 7RDX – 1036XVN','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8,'51.png','active'),(52,' Intel Core i5-8250U',20990000,0,120,'8000','Windows 10 Home','14.0 inchs FHD IPS 72%',' 8 GB DDR4 2666 MHz','MSI PS42 8M-296VN/i5-8250U','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8,'52.png','active'),(53,' Intel Core i5-8300H',21490000,0,130,'7000',' Windows 10 Home','15.6 inchs Wideview 94%NTS','8 GB DDR4 2400MHz','MSI GV62 8RC-063VN/i5-8300H','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8,'53.png','active'),(54,' Intel Core i5-8300H',22490000,0,140,'7000','Windows 10','15.6 inchs FullHD IPS 45% ',' 8 GB DDR4 2666 MHz','MSI GF63 8RC-203VN/I5-8300H','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8,'54.png','active'),(55,' Intel, Core i7, 2.8 GHz',23990000,0,150,'8000','  DOS','  17.3 inch',' 8 GB, DDR4, 2400 MHz','MSI GL72M 7REX - 1427XVN','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8,'55.png','active'),(56,' Intel, Core i7, 2.80 GHz',24990000,0,110,'7000',' Free DOS',' 15.6 inchWide-View',' 8 GB, DDR4, 2400MHz','MSI GF62 7RE-1818XVN','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8,'56.png','active'),(57,' Intel Core i7-8750H',25990000,0,110,'7000','Windows 10 Home','15.6 inchs FullHD IPS 45%',' 8 GB DDR4 2666 MHz','MSI GF63 8RD-218VN/i7-8750H','Sỡ hữu phong cách thiết kế truyền thống của MSI','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8,'57.png','active'),(58,' Intel, Core i5, 2.50 GH',19990000,0,100,'8000','Free DOS','15.6 inchWide-View',' 8 GB, DDR4, 2133 MHz','MSI GL62M 7RDX-1817XVN','Thiết kế gọn gàng để di chuyển','12 tháng','Lớp vỏ đen nhám được phủ cao su mềm đặc trưng đem đến trải nghiệm cầm nắm tốt hơn. Các thành phần của nắp máy bao gồm vỏ, màn hình và viền màn hình đều được ép chặt để tối ưu trọng lượng chỉ còn 2.2 kg',1,8,'58.png','active'),(59,'Intel Celeron N3350 1.10 GHz',4990000,0,100,'5000','Windows 10','13.3 inch FullHD IPS','3 GB LPDDR3 1600 MHz','Masstel L133','Thiết kế gọn gàng để di chuyển','6 tháng','thiết kế để giúp bạn làm việc hiệu quả suốt cả ngày dài, kể cả khi bạn đang di chuyển. Máy tính xách tay 13.3 inchs nhỏ gọn và có mức giá hợp lý, trọng lượng chỉ 1.2 Kg và thời lượng pin bền bỉ, phù hợp với những bạn trẻ năng động',1,9,'59.png','active'),(60,'Intel Celeron N3350 1.10 GHz',5490000,0,100,'5000','Windows 10','13.3 inch FullHD IPS','3 GB LPDDR3 1600 MHz',' Masstel L133/Celeron N3350','Thiết kế gọn gàng để di chuyển','6 tháng','thiết kế để giúp bạn làm việc hiệu quả suốt cả ngày dài, kể cả khi bạn đang di chuyển. Máy tính xách tay 13.3 inchs nhỏ gọn và có mức giá hợp lý, trọng lượng chỉ 1.2 Kg và thời lượng pin bền bỉ, phù hợp với những bạn trẻ năng động',1,9,'60.png','active'),(61,' Intel Celeron N3350 1.10 GHz',5990000,0,100,'4000','Windows 10',' 13.3 inch FullHD IPS',' 3 GB LPDDR3 1600 MHz','Masstel L133 Celeron N3350','Thiết kế gọn gàng để di chuyển','6 tháng','thiết kế để giúp bạn làm việc hiệu quả suốt cả ngày dài, kể cả khi bạn đang di chuyển. Máy tính xách tay 13.3 inchs nhỏ gọn và có mức giá hợp lý, trọng lượng chỉ 1.2 Kg và thời lượng pin bền bỉ, phù hợp với những bạn trẻ năng động',1,9,'61.png','active'),(62,'Intel Celeron N4100',6990000,0,50,'4000','Windows 10','13.3 inchs FullHD IPS','4 GB LPDDR4','Masstel L133 Pro/Celeron N4100','Thiết kế siêu mỏng nhẹ','6 tháng','thiết kế để giúp bạn làm việc hiệu quả suốt cả ngày dài, kể cả khi bạn đang di chuyển. Máy tính xách tay 13.3 inchs nhỏ gọn và có mức giá hợp lý, trọng lượng chỉ 1.2 Kg và thời lượng pin bền bỉ, phù hợp với những bạn trẻ năng động',1,9,'62.png','active'),(63,' Intel Celeron N3350',4499000,0,50,'5000','FreeDOS','13.3 inchs IPS LCD',' 3 GB DDR3L 1600 MHz','Haier S1 HR-13M/Celeron N3350','Thiết kế siêu mỏng nhẹ','6 tháng','Một chiếc laptop đời mới thời trang, siêu mỏng nhẹ phục vụ tối ưu cho công việc nhưng lại trong tầm giá rất rẻ',1,10,'63.png','active'),(64,' Intel Pentium N4200',7490000,0,60,'4000','FreeDOS','13.3 inchs IPS LCD',' 6 GB DDR3L 1600 MHz','Haier S1 HR-13MZ/Pentium N4200','Thiết kế siêu mỏng nhẹ','6 tháng','Một chiếc laptop đời mới thời trang, siêu mỏng nhẹ phục vụ tối ưu cho công việc nhưng lại trong tầm giá rất rẻ',1,10,'64.png','active'),(65,NULL,10300999,0,100,NULL,NULL,NULL,NULL,'PC Acer Aspire TC-780 DT.B89SV.012 i5 7400/4G/1TB/DVDRW/WL/K+M/Dos',NULL,'12 tháng','-	Bộ vi xử lý Core i5-7400 (3.00GHz,6MB) \r\n-	RAM 4 GB DDR4 2133MHz UDIMM \r\n-	Ổ cứng 1TB 3.5 inch 7200rpm \r\n-	VGA Intel HD Graphics 530',2,4,'65.png','active'),(66,NULL,9800000,0,80,NULL,NULL,NULL,NULL,'PC Acer Aspire XC-885 DT.BAQSV.001 i3 8100/4G/1TB/DVDRW/WL/K+M/Dos',NULL,'6 tháng','-	Bộ vi xử lý : Intel Core i5-7400 (3.00 GHz/6MB) \r\n-	RAM : 4 GB DDR4 2400 MHz \r\n-	Ổ cứng : 1TB SATA 3.5\" 7200RPM \r\n-	VGA : Nvidia GT720 2GB Graphics',2,4,'66.png','active'),(67,NULL,90,0,90,NULL,NULL,NULL,NULL,'PC Acer Aspire TC-780 DT.B89SV.009 G4560/4G/1TB/DVDRW/WL/K+M/Dos',NULL,'6 tháng','-	Bộ vi xử lý Pentium G4560(3.50 GHz,3MB) \r\n-	RAM 4 GB DDR4 2133MHz UDIMM \r\n-	Ổ cứng 1TB 3.5 inch 7200rpm \r\n-	VGA Intel HD Graphics',2,4,'67.png','active'),(68,NULL,190,0,100,NULL,NULL,NULL,NULL,'PC Acer Aspire TC-780 DT.B89SV.008 i3 7100/4G/1TB/DVDRW/WL/K+M/Dos',NULL,'6 tháng','-	Bộ vi xử lý Core i3-7100 (3.90 GHz,3MB) \r\n-	RAM 4 GB DDR4 2133MHz UDIMM \r\n-	Ổ cứng 1TB 3.5 inch 7200rpm \r\n-	VGA Intel HD Graphics',2,4,'68.png','active'),(69,NULL,10067840,0,90,NULL,NULL,NULL,NULL,'PC Acer Aspire M230 UX.B1JSI.H72 i3 7100/4G/1TB/DVDRW/WL/K+M/Dos',NULL,' 6 tháng','CPU i3-7100 \r\nRAM 4GB \r\nHDD 1TB',2,4,'69.png','active'),(70,NULL,19000345,0,90,NULL,NULL,NULL,NULL,'PC Acer Aspire XC-885 DT.BAQSV.002 i5 8400/4G/1TB/DVDRW/WL/K+M/Dos',NULL,'6 tháng','CPU i5-8400(6*2.80) \r\nRAM 4G \r\nHDD 1TB \r\nDOS',2,4,'70.png','active'),(71,NULL,10000012,0,300,NULL,NULL,NULL,NULL,'PC Dell Optilex 3060SFF-8400-1TBKHDD i5 8400/4GB/1TB/DVDRW/K+M/DOS',NULL,'6 tháng','PC Dell Optilex 3060SFF-8400-1TBKHDD i5 8400/4GB/1TB/DVDRW/K+M/DOS\r\n',2,5,'71.png','active'),(72,NULL,15000500,0,200,NULL,NULL,NULL,NULL,'PC Dell Vostro 3670 J84NJ2 i7 8700/8GB/1TB/DVDRW/K+M/WL/DOS',NULL,'6 tháng','Intel Core i5-8400 Processor (9MB, 6T, 2.8GHz, up to 4.0, 65W) \r\nHDD 1TB 7200 rpm SATA \r\n4GB 2666 MHz DDR4',2,5,'72.png','active'),(73,NULL,13000000,0,100,NULL,NULL,NULL,NULL,'PC Dell Vostro 3670 J84NJ21 i7 8700/8GB/1TB/GTX1050 2G/DVDRW/K+M/WL/DOS',NULL,'6 tháng','Sức mạnh xử lý: Đảm đương khối lượng công việc của bạn một cách nhanh chóng và hiệu quả với bộ vi xử lý i7-8700 thế hệ thứ 8, bộ nhớ lên đến 8GB DDR4, và card đồ họa GTX 1050. \r\nMở rộng dễ dàng: 1TB dung lượng lưu trữ HDD ',2,5,'73.png','active'),(74,NULL,12000000,0,50,NULL,NULL,NULL,NULL,'PC Dell Vostro 3670 MTI79016 i7 8700/8G/1TB/GTX1050 2G/DVDRW/K+M/WL/DOS',NULL,'6 tháng','Sức mạnh xử lý: Đảm đương khối lượng công việc của bạn một cách nhanh chóng và hiệu quả với bộ vi xử lý i7-8700 thế hệ thứ 8, bộ nhớ lên đến 8GB DDR4, và card đồ họa GTX 1050. \r\nMở rộng dễ dàng: 1TB dung lượng lưu trữ HDD',2,5,'74.png','active'),(75,NULL,12000000,0,70,NULL,NULL,NULL,NULL,'PC Dell Optilex 3050SFF-7500-1TBKHDD i5 7500/4GB/1TB/DVDRW/K+M/DOS',NULL,'6 tháng','Intel Core i5-7500 Processor (6MB, 4T, 3.4GHz, 65W) \r\nHDD 1TB 7200 rpm SATA \r\n4GB 2400MHz DDR4',2,5,'75.png','active'),(76,NULL,12500600,0,70,NULL,NULL,NULL,NULL,'PC Dell All in One 3277B Pentium 4415U/4GB/1TB/21.5\" FHD/K+M/WL/Win10',NULL,'6 tháng','Intel Pentium 4415U (2.30GHz, 3MB), \r\n4GB DDR4 2400MHz, \r\nHDD 1TB, Intel HD Graphics 620 , \r\n21.5 inch Full HD IPS LED Backlit \r\nWin 10',2,5,'76.png','active'),(77,NULL,13400000,0,100,NULL,NULL,NULL,NULL,'PC HP Pavilion 590-p0055d 4LY13AA i5 8400/4GB/1TB/DVDRW/K+M/Win10',NULL,'6 tháng','Bộ Vi xử lý: Core i5-8400(2.80 GHz,9MB) \r\nRAM: 4GB DDR4 \r\nỔ cứng: 1TB HDD \r\nHệ điều hành: Win 10 Home 64',2,6,'77.png','active'),(78,NULL,12000670,0,100,NULL,NULL,NULL,NULL,'PC HP 280 G4 MT i7 8700/8GB/1TB/DVDRW/K+M/DOS ( 4LU27PA )',NULL,'6 tháng','Máy tính để bàn HP 280 G4 Microtower - 4LU27PA \r\nBộ vi xử lý Core i7-8700(3.20 GHz,12MB) \r\n8GB RAM DDR4, 1TB HDD, DVDRW \r\nĐồ họa Intel UHD Graphics, Keyboard, USB Mouse,FreeDos',2,6,'78.png','active'),(79,NULL,12000500,0,70,NULL,NULL,NULL,NULL,'PC HP ProDesk 400 G5 SFF i5 8500/4GB/500GB/DVDRW/K+M/DOS ( 4TT16PA )',NULL,'6 tháng','PC HP ProDesk 400 G5 SFF - 4TT16PA \r\nBộ vi xử lý Intel Core i5 8500 3.0Ghz \r\nRAM 4GB / 500GB / DVDRW',2,6,'79.png','active'),(80,NULL,14500500,0,80,NULL,NULL,NULL,NULL,'PC HP 280 G4 MT 4LU29PA i3 8100/4GB/1TB/DVDRW/K+M/DOS',NULL,'6 tháng','Máy tính để bàn HP 280 G4 Microtower - 4LU29PA \r\nBộ vi xử lý Intel Core i3-8100(3.60 GHz,6MB) \r\n4GB RAM DDR4, 1TB HDD, DVDRW \r\nIntel UHD Graphics, Keyboard, USB Mouse, FreeDos',2,6,'80.png','active'),(81,NULL,11600000,0,90,NULL,NULL,NULL,NULL,'PC HP 270-p010d i5 7400T/4GB/1TB/AMD R5 435 2GB/DVDRW/K+M/WL/Win10 (3JT58AA )',NULL,'6 tháng','Máy tính để bàn HP 280 G4 Microtower - 4LU29PA \r\nBộ vi xử lý Intel Core i3-8100(3.60 GHz,6MB) \r\n4GB RAM DDR4, 1TB HDD, DVDRW \r\nIntel UHD Graphics, Keyboard, USB Mouse, FreeDos',2,6,'81.png','active'),(82,NULL,13500000,0,80,NULL,NULL,NULL,NULL,'PC Lenovo ThinkCentre V520 10NKA00EVA i3 7100/4GB/1TB/DVDRW/K+M/Dos',NULL,'6 tháng','PC Lenovo V530S - 10TXA001VA \r\nBộ vi xử lý Intel Celeron G4900 3.1Ghz \r\nRAM 4GB/ HDD 500GB/ K+M/ WL/ DOS',2,7,'82.png','active'),(83,NULL,12700500,0,70,NULL,NULL,NULL,NULL,'PC Lenovo IdeaCentre 510s-08IKL 90GB00EVVN i3 7100/4GB/1TB/DVDRW/WL/K+M/Win10',NULL,'6 tháng','-	Bộ vi xử lý : Intel Core i3-7100 Processor (2 x 3.90GHz) \r\n-	RAM : 4GB DDR4/ 2400MHz \r\n-	Ổ cứng : 1TB SATA3 (7200rpm) \r\n-	VGA : Intel HD Graphics 630',2,7,'83.png','active'),(84,NULL,10400000,0,90,NULL,NULL,NULL,NULL,'PC Lenovo ThinkCentre V520 10NKA00DVA G4560 /4GB/500GB/DVDRW/K+M/Dos',NULL,'6 tháng','Bộ vi xử lý	Intel G4560 \r\nChipset	Intel B250 Chipset \r\nBộ nhớ trong	4GB DDR4 \r\nSố khe cắm	2 \r\nDung lượng tối đa	32GB \r\nVGA	Intel® HD 610 \r\nỔ cứng	500GB 7200RPM \r\nỔ quang	DVDRW',2,7,'84.png','active'),(85,NULL,15000000,0,80,NULL,NULL,NULL,NULL,'PC Lenovo ThinkCentre V520 10NKA00TVA i7 7700/4GB/1TB/DVDRW/K+M/Dos',NULL,'6 tháng','CPU i7-7700(3.6GHz/8MB) \r\nRAM 4GB DDR4 \r\nHDD 1TB 7200RPM, \r\nDVDRW, \r\nUSB Calliope Keyboard,USB Mouse',2,7,'85.png','active'),(86,NULL,10500000,0,90,NULL,NULL,NULL,NULL,'PC Lenovo IdeaCentre 510-15IKL 90G800HEVN Pentium G4560/4GB/1TB/DVDRW/WL/K+M/Win10',NULL,'6 tháng','-	Bộ vi xử lý: Intel Core i3-7100 ( 3.90 GHz / 3MB cache ) \r\n-	RAM: 4GB DDR4 2400UDIMM \r\n-	Ổ cứng: 1TB SATA 7200RPM \r\n-	VGA: Intel® HD Graphics 630',2,7,'86.png','active'),(87,NULL,10500000,0,90,NULL,NULL,NULL,NULL,'PC Lenovo V530S-07ICB i3 8100/4GB/1TB/K+M/WL/Win10 ( 10TXA000VN )',NULL,'6 tháng','PC Lenovo V530S-07ICB - 10TXA000VN \r\nBộ vi xử lý Intel Core i3 8100 3.6Ghz \r\nRAM 4GB/ HDD 1TB/ K+M/ WL/ Win10',2,7,'87.png','active'),(88,NULL,124000000,0,80,NULL,NULL,NULL,NULL,'PC Lenovo ThinkCentre V520 10NKA00TVA i7 7700/4GB/1TB/DVDRW/K+M/Dos',NULL,'6 tháng','CPU i7-7700(3.6GHz/8MB) \r\nRAM 4GB DDR4 \r\nHDD 1TB 7200RPM, \r\nDVDRW, \r\nUSB Calliope Keyboard,USB Mouse',2,7,'88.png','active'),(89,NULL,2800500,0,100,NULL,NULL,NULL,NULL,'Tai nghe ASUS ROG Strix Fusion 300 Surround 7.1',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nHệ thống Led màu đỏ nổi bật \r\nCó thể sử dụng 3,5mm và USB linh hoạt',3,3,'89.png','active'),(90,NULL,3200000,0,120,NULL,NULL,NULL,NULL,'Tai nghe ASUS ROG Strix Fusion Wireless',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3,'90.png','active'),(91,NULL,10000000,0,90,NULL,NULL,NULL,NULL,'Tai nghe ASUS ROG Strix Fusion 500',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nHệ thống Led RGB 16,8 triệu màu \r\nCó thể sử dụng 3,5mm và USB linh hoạt \r\nĐiều chỉnh qua bề mặt cảm ứng của củ tai',3,3,'91.png','active'),(92,NULL,4200123,0,100,NULL,NULL,NULL,NULL,'Tai nghe Asus STRIX 2.0- ROG Gaming Headset',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nHệ thống Led RGB 16,8 triệu màu \r\nCó thể sử dụng 3,5mm và USB linh hoạt \r\nĐiều chỉnh qua bề mặt cảm ứng của củ tai',3,3,'92.png','active'),(93,NULL,3200000,1,49,NULL,NULL,NULL,NULL,'Tai nghe Asus Centurion - ROG Gaming Headset',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3,'93.png','active'),(94,NULL,1002356,0,60,NULL,NULL,NULL,NULL,'Tai Nghe Asus CERBERUS V2 - Red / Black',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3,'94.png','active'),(95,NULL,2500000,0,70,NULL,NULL,NULL,NULL,'Tai nghe Asus Gaming Asus Strix Pro',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3,'95.png','active'),(96,NULL,3000000,0,100,NULL,NULL,NULL,NULL,'Tai nghe Asus gaming ROG Strix Wireless',NULL,'6 tháng','Tai nghe chơi game cao cấp từ ASUS ROG \r\nMàng loa dài 50mm \r\nGiả lập âm thanh vòm 7.1 \r\nThiết kế trùm tai cho độ thoải mái tối đa \r\nKết nối không dây No-Lag qua USB Receiver',3,3,'96.png','active'),(97,NULL,43000000,0,100,NULL,NULL,NULL,NULL,'Màn hình Acer Nitro 23.8\"VG240Y LED IPS',NULL,'6 tháng','Kích Thước Màn Hình	23.8 INCH \r\nĐộ Sáng Màn Hình	250 cd/m² \r\nTỉ Lệ Tương Phản Động MEGA	100,000,000:1 \r\nĐộ Phân Giải Màn Hình	1920*1080 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16.7 million colours \r\nGóc nhìn	178/178',4,4,'97.png','active'),(98,NULL,50000000,0,200,NULL,NULL,NULL,NULL,'Monitor Acer 21.5\"R221Q LED IPS',NULL,'6 tháng','Kích Thước Màn Hình	23.8 INCH \r\nĐộ Sáng Màn Hình	250 cd/m² \r\nTỉ Lệ Tương Phản Động MEGA	100,000,000:1 \r\nĐộ Phân Giải Màn Hình	1920*1080 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16.7 million colours \r\nGóc nhìn	178/178',4,4,'98.png','active'),(99,NULL,5200000,0,100,NULL,NULL,NULL,NULL,'Màn hình Acer 19.5\"K202HQL LED',NULL,'6 tháng','Kích Thước Màn Hình	27\'\' \r\nĐộ Sáng Màn Hình	350 cd/m² \r\nĐộ Phân Giải Màn Hình	2560 x 1440 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16,7 Triệu Màu \r\nGóc nhìn	178°/178° \r\nTín hiệu đầu vào	HDMI, DP \r\nMức Tiêu Thụ̣ Điện	26W',4,4,'99.png','active'),(100,NULL,2000000,0,100,NULL,NULL,NULL,NULL,'Màn hình Acer Nitro 27\"VG270 LED IPS',NULL,'6 tháng','Size	27” \r\nĐộ phân giải	Full HD (1920 x 1080) \r\nTỷ lệ khung hình	16:9 \r\nThời gian đáp ứng: 1 ms \r\nRefresh Rate	75 Hz \r\nHỗ trợ màu	16.7 million \r\nĐộ sáng	250 cd/m² \r\nBacklight	LED',4,4,'100.png','active'),(101,NULL,1200000,0,12,NULL,NULL,NULL,NULL,'Màn hình Acer 18.5\"EB192Q LED',NULL,'6 tháng','Kích Thước Màn Hình	23.8 INCH \r\nĐộ Sáng Màn Hình	250 cd/m² \r\nTỉ Lệ Tương Phản Động MEGA	100,000,000:1 \r\nĐộ Phân Giải Màn Hình	1920*1080 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16.7 million colours \r\nGóc nhìn	178/178',4,4,'101.png','active'),(102,NULL,12000000,0,123,NULL,NULL,NULL,NULL,'Màn hình Acer 27\"KG271 LED IPS',NULL,'6 tháng','Kích Thước Màn Hình	23.8 INCH \r\nĐộ Sáng Màn Hình	250 cd/m² \r\nTỉ Lệ Tương Phản Động MEGA	100,000,000:1 \r\nĐộ Phân Giải Màn Hình	1920*1080 \r\nThời Gian Đáp Ứng	1ms \r\nHỗ trợ màu	16.7 million colours \r\nGóc nhìn	178/178',4,4,'102.png','active'),(103,NULL,300000,1,122,NULL,NULL,NULL,NULL,'Bàn Phím Asus ROG Claymore Ultimate RGB Aura Sync Cherry Red switch',NULL,'6 tháng','Bàn Phím Asus ROG Claymore Ultimate RGB Aura Sync Cherry Red switch',4,3,'103.png','active'),(104,NULL,4000000,0,123,NULL,NULL,NULL,NULL,'Keyboard ASUS ROG Strix Flare Cherry Blue switch',NULL,'6 tháng','Keyboard ASUS ROG Strix Flare Cherry Blue switch',4,3,'104.png','active'),(105,NULL,5432584,0,123,NULL,NULL,NULL,NULL,'Keyboard ASUS Strix Tactic Pro Mechanical Blue',NULL,'6 tháng','Keyboard ASUS Strix Tactic Pro Mechanical Blue',4,3,'105.png','active'),(106,NULL,1200000,0,123,NULL,NULL,NULL,NULL,'Mouse ASUS ROG Strix Impact',NULL,'2 tháng','Mouse ASUS ROG Strix Impact',4,3,'106.png','active'),(107,NULL,100000,0,123,NULL,NULL,NULL,NULL,'Mouse ASUS ROG Gladius II',NULL,'2 tháng','Chuột chơi game cho game thủ chuyên nghiệp của Asus ROG \r\nHệ thống led RGB tích hợp công nghệ Aura Sync với Mainboard và VGA \r\nThiết kế Ergonomics phù hợp với kiểu cầm chuột Palm Grip và Claw Grip \r\n',4,3,'107.png','active'),(108,NULL,3000000,0,123,NULL,NULL,NULL,NULL,'Mouse Asus ROG Spatha - Super MMO Gaming Mouse',NULL,'2 tháng','Mouse Asus ROG Spatha - Super MMO Gaming Mouse\r\n',4,3,'108.png','active'),(109,NULL,200000,0,1000,NULL,NULL,NULL,NULL,'MicroSDHC SILICON POWER UHS-I 32GB W/A',NULL,'2 tháng','MicroSDHC SILICON POWER UHS-I 32GB W/A',5,2,'109.png','active'),(110,NULL,30000,0,100,NULL,NULL,NULL,NULL,'HDD Western Caviar Black 500GB 7200Rpm, SATA3 6Gb/s, 64MB Cache',NULL,'2 tháng','HDD Western Caviar Black 500GB 7200Rpm, SATA3 6Gb/s, 64MB Cache\r\n',5,2,'110.png','active'),(111,NULL,1230000,0,100,NULL,NULL,NULL,NULL,'SSD Kingston Furry RGB 240GB Sata3 2.5\" (Doc 550MB/s, Ghi 480MB/s) - SHFR200/240G',NULL,'2 tháng','SSD Kingston Furry RGB 240GB Sata3 2.5\" (Doc 550MB/s, Ghi 480MB/s) - SHFR200/240G',5,3,'111.png','active'),(112,NULL,1230000,0,1000,NULL,NULL,NULL,NULL,'SSD AVEXIR S100 White 120GB SATA3 6Gb/s 2.5\" (Read 550MB/s, Write 275MB/s)',NULL,'2 tháng','SSD AVEXIR S100 White 120GB SATA3 6Gb/s 2.5\" (Read 550MB/s, Write 275MB/s)',5,2,'112.png','active'),(113,NULL,1200000,0,100,NULL,NULL,NULL,NULL,'Handy Kingston 32GB DATA TRAVELER DT SWIVL USB 3.0',NULL,'2 tháng','Handy Kingston 32GB DATA TRAVELER DT SWIVL USB 3.0',5,2,'113.png','active'),(114,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Handy Kingston 16GB DATA TRAVELER DT SWIVL USB 3',NULL,'2 tháng','Handy Kingston 16GB DATA TRAVELER DT SWIVL USB 3',5,2,'114.png','active'),(115,NULL,1200000,0,123,NULL,NULL,NULL,NULL,'USB3.0 SILICON POWER Marvel M50 16GB',NULL,'2 tháng','USB3.0 SILICON POWER Marvel M50 16GB',5,2,'115.png','active'),(116,NULL,3000000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-N14UHP N300 3-in-1 Wi-Fi Router / Access Point / Repeater',NULL,'2 tháng','Router ASUS RT-N14UHP N300 3-in-1 Wi-Fi Router / Access Point / Repeater',6,3,'116.png','active'),(117,NULL,1200000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-N12+ 3-in-1 Router/AP/Range',NULL,'2 tháng','Router ASUS RT-N12+ 3-in-1 Router/AP/Range\r\n',6,3,'117.png','active'),(118,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-N12HP (Black Diamond) N300 3-in-1 Wi-Fi Router / Access Point / Repeater',NULL,'2 tháng','Router ASUS RT-N12HP (Black Diamond) N300 3-in-1 Wi-Fi Router / Access Point / Repeater',6,3,'118.png','active'),(119,NULL,1000000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-AC86U',NULL,'2 tháng','Router ASUS RT-AC86U',6,3,'119.png','active'),(120,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-A1300UHP',NULL,'2 tháng','Router ASUS RT-A1300UHP',6,3,'120.png','active'),(121,NULL,200000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-AC68U',NULL,'2 tháng','Router ASUS RT-AC68U',6,3,'121.png','active'),(122,NULL,230000,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-AC58U',NULL,'2 tháng','Router ASUS RT-AC58U',6,3,'122.png','active'),(123,NULL,1299999,0,100,NULL,NULL,NULL,NULL,'Router ASUS RT-AC53',NULL,'2 tháng','Router ASUS RT-AC53',6,3,'123.png','active'),(124,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Camera Thân IP HikVision DS-2CD1023G0-I H265+',NULL,'2 tháng','Camera Thân IP HikVision DS-2CD1023G0-I H265+',7,2,'124.png','active'),(125,NULL,12000000,0,100,NULL,NULL,NULL,NULL,'Camera IP Hikvision Dome HIK -HDIP2820FH 2.0M',NULL,'2 tháng','Camera IP Hikvision Dome HIK -HDIP2820FH 2.0M',7,2,'125.png','active'),(126,NULL,1200000,0,100,NULL,NULL,NULL,NULL,'Camera Vantech FullHD HD-SDI VP-120HD',NULL,'2 tháng','Camera Vantech FullHD HD-SDI VP-120HD',7,2,'126.png','active'),(127,NULL,123000,0,100,NULL,NULL,NULL,NULL,'Camera Dome Vantech VP- 4224T VT 1230',NULL,'2 tháng','Camera Dome Vantech VP- 4224T',7,2,'127.png','active'),(128,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Camera Thân TVI HikVision DS-2CE16C0T-IRP',NULL,'2 tháng','Camera Thân TVI HikVision DS-2CE16C0T-IRP',7,2,'128.png','active'),(129,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Camera Thân TVI HikVision DS-2CE16C0T-IRP',NULL,'2 tháng','Camera Thân TVI HikVision DS-2CE16C0T-IRP',7,2,'129.png','active'),(130,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Camera IP Vantech quay quét VT-6300C',NULL,'2 tháng','Camera IP Vantech quay quét VT-6300C',7,2,'130.png','active'),(131,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Camera IP Thân Hikvision DS-2CD2055FWD-I   H.265+',NULL,'2 tháng','Camera IP Thân Hikvision DS-2CD2055FWD-I   H.265+',7,3,'131.png','active'),(132,NULL,123000,0,100,NULL,NULL,NULL,NULL,'Mouse Pad Madcatz G.L.I.D.E.7',NULL,'2 tháng','Mouse Pad Madcatz G.L.I.D.E.7',8,3,'132.png','active'),(133,NULL,0,0,100,NULL,NULL,NULL,NULL,'Đế Làm Mát Laptop Cooling pad N99',NULL,'2 tháng','Đế Làm Mát Laptop Cooling pad N99',8,2,'133.png','active'),(134,NULL,123000,0,100,NULL,NULL,NULL,NULL,'Mouse Pad Razer Goliathus SKT T1 Edition',NULL,'2 tháng','Mouse Pad Razer Goliathus SKT T1 Edition - Soft Gaming Mouse Mat - Medium - Speed  (355mm x 254mm)',8,4,'134.png','active'),(135,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Mouse Pad Razer Goliathus Medium 2014 (250x300mm)',NULL,'2 tháng','Mouse Pad Razer Goliathus Medium 2014 (250x300mm)',8,6,'135.png','active'),(136,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Cable HDMI 15m Vention',NULL,'1 tháng','Cable HDMI 15m Vention version 1.4',9,2,'136.png','active'),(137,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Cable HDMI dẹt 1.5m Vention ',NULL,'1 tháng','Cable HDMI dẹt 1.5m Vention version 1.4',9,3,'137.png','active'),(138,NULL,1500000,0,100,NULL,NULL,NULL,NULL,'Cable màn hình VGA ',NULL,'1 tháng','Cable màn hình VGA 1m -1.5m (Từ cổng 15 đực sang 15 đực)',9,5,'138.png','active'),(139,NULL,120000,0,100,NULL,NULL,NULL,NULL,'Cable HDMI dẹt 10m Vention version 1.4',NULL,'2 tháng','Cable HDMI dẹt 10m Vention version 1.4',9,5,'139.png','active'),(140,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Bộ chuyển đổi HDMI sang VGA',NULL,'1 tháng','Bộ chuyển đổi HDMI sang VGA( có Audio) Vention Black Metal Type',9,5,'140.png','active'),(141,NULL,100000,0,100,NULL,NULL,NULL,NULL,'Cáp chuyển HDMI sang VGA ',NULL,'3 tháng','Cáp chuyển HDMI sang VGA Hỗ trợ Full HD DHTV-C20 Orico',9,5,'141.png','active'),(142,NULL,140000,0,100,NULL,NULL,NULL,NULL,'Cable HDMI 1.5m',NULL,'2 tháng','Cable HDMI 1.5m Version 2.0 hỗ trợ 4K 60Mhz',9,3,'142.png','active'),(143,NULL,1000000,0,100,NULL,NULL,NULL,NULL,'Cáp chuyển TypeC ',NULL,'2 tháng','Cáp chuyển TypeC sang 5 cổng HDMI/TypeC/2*USB 3.0 RCH3A-GD Orico',9,6,'143.png','active');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `rating_score` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKRating_Product` (`product_id`),
  KEY `FKRating_User` (`user_id`),
  CONSTRAINT `FKRating_Product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKRating_User` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (1,4,2,NULL,'Sản phẩm rất tuyệt','2024-06-20 23:06:51',1),(2,4,27,NULL,'10 điểm','2024-06-20 23:23:38',1),(3,4,27,NULL,'10000 điểm','2024-06-20 23:26:05',5),(4,93,27,NULL,'fhjkafal','2024-06-21 11:38:49',5),(5,93,27,NULL,'fadsklfhas','2024-06-21 11:39:14',4),(6,93,2,NULL,'ddddddddd','2024-06-21 11:40:33',5),(7,7,27,NULL,'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed felis est. Ut fringilla, elit id gravida tincidunt, lectus nulla luctus mi, a tempus leo metus et elit. In vel massa velit. Proin accumsan luctus diam vel vulputate. Mauris convallis imperdiet ante.','2024-06-21 13:48:21',4),(8,54,2,NULL,'Nam ante magna, lacinia nec urna sit amet, finibus blandit lorem. Mauris est purus, egestas id purus sit amet, rhoncus feugiat lectus. Aliquam erat volutpat. Nunc egestas suscipit erat id bibendum. Duis.','2024-06-21 15:25:49',5);
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ADMIN'),(2,'SALER'),(3,'MEMBER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKEmail` (`email`),
  KEY `FKUser_Role` (`role_id`),
  CONSTRAINT `FKUser_Role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Hà Nội','admin@gmail.com','Nguyễn Xuân Nam','$2a$10$3mIWjShzTyfEqzVoRwyUjOK4XlWk7TjcjrO3xaFcXjlfq6ES4bnD6','123456789',1,'active'),(2,NULL,'member@gmail.com','Nombre Noir','$2a$10$Zk9MSaYLQzuR3AduX8jM2.z3otHgBpkVeQPjSkvL/XfP3e1xD0h5S',NULL,3,'active'),(3,NULL,'saler@gmail.com','Makima Tokizawa','$2a$10$1A2jZwaq02MViKmdEgSyou/1eBdLt9QdkJz10qUnApYDxqv3P5CKy',NULL,2,'active'),(4,'Ha Noi','jvgiveup@gmail.com','Pham Tuan','$2a$10$lHb9AJ4TSJpOMYmhsbpPKOF70JO.D0tuol8n0jMpy7qzAt842Xv/K','123456',3,'active'),(23,NULL,'dangtm1163@gmail.com','Minh Đăng','$2a$10$X4HjBeEX.xwIJyHmrMUuSupw85BeBDNWLrhD6N8Xdf2f/yvuEqNhK',NULL,2,'active'),(27,NULL,'ruabin1163@gmail.com','Tạ Minh Đăng','$2a$10$w1VC/kjDg8wUJ/aYy3i82.VjWKudrkKz3dinNRPX1nqePTJ.2oC5u',NULL,3,'active');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-21 20:09:46

-- MySQL dump 10.13  Distrib 5.7.23, for osx10.9 (x86_64)
--
-- Host: localhost    Database: antoinette
-- ------------------------------------------------------
-- Server version	5.7.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `antoinette`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `antoinette` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `antoinette`;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_commentmeta`
--

LOCK TABLES `wp_commentmeta` WRITE;
/*!40000 ALTER TABLE `wp_commentmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_commentmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_comments`
--

LOCK TABLES `wp_comments` WRITE;
/*!40000 ALTER TABLE `wp_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_links`
--

LOCK TABLES `wp_links` WRITE;
/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
INSERT INTO `wp_options` VALUES (1,'siteurl','http://localhost:9090','yes'),(2,'home','http://localhost:9090','yes'),(3,'blogname','antoinette','yes'),(4,'blogdescription','Just another WordPress site','yes'),(5,'users_can_register','0','yes'),(6,'admin_email','wptemplate@studioakademi.com','yes'),(7,'start_of_week','1','yes'),(8,'use_balanceTags','0','yes'),(9,'use_smilies','1','yes'),(10,'require_name_email','1','yes'),(11,'comments_notify','1','yes'),(12,'posts_per_rss','10','yes'),(13,'rss_use_excerpt','0','yes'),(14,'mailserver_url','mail.example.com','yes'),(15,'mailserver_login','login@example.com','yes'),(16,'mailserver_pass','password','yes'),(17,'mailserver_port','110','yes'),(18,'default_category','1','yes'),(19,'default_comment_status','open','yes'),(20,'default_ping_status','open','yes'),(21,'default_pingback_flag','1','yes'),(22,'posts_per_page','10','yes'),(23,'date_format','F j, Y','yes'),(24,'time_format','g:i a','yes'),(25,'links_updated_date_format','F j, Y g:i a','yes'),(26,'comment_moderation','0','yes'),(27,'moderation_notify','1','yes'),(28,'permalink_structure','/index.php/%postname%/','yes'),(29,'rewrite_rules','a:88:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:57:\"index.php/category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:52:\"index.php/category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:33:\"index.php/category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:45:\"index.php/category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:27:\"index.php/category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:54:\"index.php/tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:49:\"index.php/tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:30:\"index.php/tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:42:\"index.php/tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:24:\"index.php/tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:55:\"index.php/type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:50:\"index.php/type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:31:\"index.php/type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:43:\"index.php/type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:25:\"index.php/type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:42:\"index.php/feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:37:\"index.php/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:18:\"index.php/embed/?$\";s:21:\"index.php?&embed=true\";s:30:\"index.php/page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:37:\"index.php/comment-page-([0-9]{1,})/?$\";s:39:\"index.php?&page_id=30&cpage=$matches[1]\";s:51:\"index.php/comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:46:\"index.php/comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:27:\"index.php/comments/embed/?$\";s:21:\"index.php?&embed=true\";s:54:\"index.php/search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:49:\"index.php/search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:30:\"index.php/search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:42:\"index.php/search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:24:\"index.php/search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:57:\"index.php/author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:52:\"index.php/author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:33:\"index.php/author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:45:\"index.php/author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:27:\"index.php/author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:79:\"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:74:\"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:55:\"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:67:\"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:49:\"index.php/([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:66:\"index.php/([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:61:\"index.php/([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:42:\"index.php/([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:54:\"index.php/([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:36:\"index.php/([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:53:\"index.php/([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:48:\"index.php/([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:29:\"index.php/([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:41:\"index.php/([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:23:\"index.php/([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:37:\"index.php/.?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:47:\"index.php/.?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:67:\"index.php/.?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"index.php/.?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"index.php/.?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:43:\"index.php/.?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:26:\"index.php/(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:30:\"index.php/(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:50:\"index.php/(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:45:\"index.php/(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:38:\"index.php/(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:45:\"index.php/(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:34:\"index.php/(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";s:37:\"index.php/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:47:\"index.php/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:67:\"index.php/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"index.php/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"index.php/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:43:\"index.php/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:26:\"index.php/([^/]+)/embed/?$\";s:37:\"index.php?name=$matches[1]&embed=true\";s:30:\"index.php/([^/]+)/trackback/?$\";s:31:\"index.php?name=$matches[1]&tb=1\";s:50:\"index.php/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:45:\"index.php/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:38:\"index.php/([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&paged=$matches[2]\";s:45:\"index.php/([^/]+)/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&cpage=$matches[2]\";s:34:\"index.php/([^/]+)(?:/([0-9]+))?/?$\";s:43:\"index.php?name=$matches[1]&page=$matches[2]\";s:26:\"index.php/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:36:\"index.php/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:56:\"index.php/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:51:\"index.php/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:51:\"index.php/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:32:\"index.php/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";}','yes'),(30,'hack_file','0','yes'),(31,'blog_charset','UTF-8','yes'),(32,'moderation_keys','','no'),(33,'active_plugins','a:2:{i:0;s:34:\"advanced-custom-fields-pro/acf.php\";i:1;s:33:\"classic-editor/classic-editor.php\";}','yes'),(34,'category_base','','yes'),(35,'ping_sites','http://rpc.pingomatic.com/','yes'),(36,'comment_max_links','2','yes'),(37,'gmt_offset','0','yes'),(38,'default_email_category','1','yes'),(39,'recently_edited','a:2:{i:0;s:87:\"/Users/fhaglund/dev/wp-template/build/wp-content/plugins/advanced-custom-fields/acf.php\";i:1;s:0:\"\";}','no'),(40,'template','akademi','yes'),(41,'stylesheet','akademi','yes'),(42,'comment_whitelist','1','yes'),(43,'blacklist_keys','','no'),(44,'comment_registration','0','yes'),(45,'html_type','text/html','yes'),(46,'use_trackback','0','yes'),(47,'default_role','subscriber','yes'),(48,'db_version','43764','yes'),(49,'uploads_use_yearmonth_folders','1','yes'),(50,'upload_path','','yes'),(51,'blog_public','1','yes'),(52,'default_link_category','2','yes'),(53,'show_on_front','page','yes'),(54,'tag_base','','yes'),(55,'show_avatars','1','yes'),(56,'avatar_rating','G','yes'),(57,'upload_url_path','','yes'),(58,'thumbnail_size_w','150','yes'),(59,'thumbnail_size_h','150','yes'),(60,'thumbnail_crop','1','yes'),(61,'medium_size_w','300','yes'),(62,'medium_size_h','300','yes'),(63,'avatar_default','mystery','yes'),(64,'large_size_w','1024','yes'),(65,'large_size_h','1024','yes'),(66,'image_default_link_type','none','yes'),(67,'image_default_size','','yes'),(68,'image_default_align','','yes'),(69,'close_comments_for_old_posts','0','yes'),(70,'close_comments_days_old','14','yes'),(71,'thread_comments','1','yes'),(72,'thread_comments_depth','5','yes'),(73,'page_comments','0','yes'),(74,'comments_per_page','50','yes'),(75,'default_comments_page','newest','yes'),(76,'comment_order','asc','yes'),(77,'sticky_posts','a:0:{}','yes'),(78,'widget_categories','a:2:{i:2;a:4:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:12:\"hierarchical\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}','yes'),(79,'widget_text','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','yes'),(80,'widget_rss','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','yes'),(81,'uninstall_plugins','a:1:{s:33:\"classic-editor/classic-editor.php\";a:2:{i:0;s:14:\"Classic_Editor\";i:1;s:9:\"uninstall\";}}','no'),(82,'timezone_string','','yes'),(83,'page_for_posts','0','yes'),(84,'page_on_front','30','yes'),(85,'default_post_format','0','yes'),(86,'link_manager_enabled','0','yes'),(87,'finished_splitting_shared_terms','1','yes'),(88,'site_icon','0','yes'),(89,'medium_large_size_w','768','yes'),(90,'medium_large_size_h','0','yes'),(91,'initial_db_version','38590','yes'),(92,'wp_user_roles','a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:61:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}}','yes'),(93,'fresh_site','0','yes'),(94,'widget_search','a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}','yes'),(95,'widget_recent-posts','a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}','yes'),(96,'widget_recent-comments','a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}','yes'),(97,'widget_archives','a:2:{i:2;a:3:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}','yes'),(98,'widget_meta','a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}','yes'),(99,'sidebars_widgets','a:3:{s:19:\"wp_inactive_widgets\";a:0:{}s:18:\"orphaned_widgets_1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:13:\"array_version\";i:3;}','yes'),(100,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(101,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(102,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(103,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(104,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(105,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(106,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(107,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(108,'cron','a:6:{i:1552313223;a:1:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1552338227;a:3:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1552379792;a:1:{s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1552382175;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1552387994;a:1:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}s:7:\"version\";i:2;}','yes'),(117,'logged_in_key','< _;Jx}^Zri crhW7-{SRd|O+3d$v-5zH/taXe^,a@;,a|387ah8@,v~o4BgpW<F','no'),(118,'logged_in_salt','7ptq=*(H/v2!t2vU~Zj+Rp$#{<~q+wj2ku*Oh/Ci%`sCF9rp_=iCL0+:1h_mL oJ','no'),(119,'auth_key',']neHRMqbTqw!`imr]HE`yf/:#p4L#!W!`,NwMY[JKpm%[d?SKc34arohg?oA5zUt','no'),(120,'auth_salt','_oN{Gri:Dwn9>joOYo{/>?lB{cA}5Q=@xC+ySoO3B.99!3YUAM~0i;07l5~6.~WH','no'),(121,'nonce_key','-pRO#=J?Hk!ml&xq)9WKHO5MDfykw]8RxCfaRL,c%w;<2`@!1a,]v-e_]n^yU)8m','no'),(122,'nonce_salt','W3Gt-:[i8BObD%s@3B;8b!zlGs#TUYZ;SDEaa+V9v34C*Ot#HpnuL<3;m?4GO3DU','no'),(141,'theme_mods_twentyseventeen','a:1:{s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1502708009;s:4:\"data\";a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:9:\"sidebar-2\";a:0:{}s:9:\"sidebar-3\";a:0:{}}}}','yes'),(142,'current_theme','Akademi','yes'),(143,'theme_mods_akademi','a:2:{i:0;b:0;s:18:\"custom_css_post_id\";i:-1;}','yes'),(144,'theme_switched','','yes'),(149,'recently_activated','a:0:{}','yes'),(163,'acf_version','5.7.9','yes'),(169,'acf_pro_license','YToyOntzOjM6ImtleSI7czo3MjoiYjNKa1pYSmZhV1E5TmpVME56VjhkSGx3WlQxa1pYWmxiRzl3WlhKOFpHRjBaVDB5TURFMUxURXdMVEF4SURBNU9qQXlPak16IjtzOjM6InVybCI7czoyMToiaHR0cDovL2xvY2FsaG9zdDo5MDkwIjt9','yes'),(170,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),(173,'wp_page_for_privacy_policy','0','yes'),(174,'show_comments_cookies_opt_in','0','yes'),(175,'db_upgraded','','yes'),(179,'can_compress_scripts','1','no'),(189,'options_google_analytics_id','my-google-id','no'),(190,'_options_google_analytics_id','field_5c4ec48b4e1aa','no'),(193,'category_children','a:0:{}','yes');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_postmeta`
--

LOCK TABLES `wp_postmeta` WRITE;
/*!40000 ALTER TABLE `wp_postmeta` DISABLE KEYS */;
INSERT INTO `wp_postmeta` VALUES (20,8,'_edit_lock','1552293376:1'),(21,15,'_edit_lock','1552308310:1'),(22,17,'_edit_last','1'),(23,17,'_edit_lock','1552309539:1'),(24,22,'_edit_lock','1552293538:1'),(25,8,'_wp_trash_meta_status','publish'),(26,8,'_wp_trash_meta_time','1552293734'),(27,8,'_wp_desired_post_slug','group_5c4ec50d044b0'),(28,25,'_edit_last','1'),(29,25,'_edit_lock','1552309687:1'),(30,25,'sections_0_header','A bold header!'),(31,25,'_sections_0_header','field_5c861ea8bfe03'),(32,25,'sections_0_header_size','h1'),(33,25,'_sections_0_header_size','field_5c861eb9bfe04'),(34,25,'sections_1_text','paragraf 1\r\n\r\nparagraf 2\r\nrad 2'),(35,25,'_sections_1_text','field_5c861edcbfe06'),(36,25,'sections','a:4:{i:0;s:6:\"header\";i:1;s:9:\"paragraph\";i:2;s:12:\"product_list\";i:3;s:14:\"single_product\";}'),(37,25,'_sections','field_5c861e95bfe02'),(38,26,'sections_0_header','A bold header!'),(39,26,'_sections_0_header','field_5c861ea8bfe03'),(40,26,'sections_0_header_size','h1'),(41,26,'_sections_0_header_size','field_5c861eb9bfe04'),(42,26,'sections_1_text','Lorem ipsum dolor sit amet, consectetur adipiscing elit. <a href=\"http://www.google.se\">Donec tincidunt non turpis sit amet semper</a>. Nullam lobortis scelerisque dignissim. Sed convallis imperdiet leo, sed viverra risus cursus eu. Sed arcu metus, sagittis a semper ac, posuere eget nulla. Nullam ac mollis dolor, eget pulvinar enim. Donec sodales nisl ut eleifend auctor. Etiam quis aliquam eros. Phasellus vitae neque nec mi tincidunt pretium sed sed quam. Suspendisse condimentum nibh sed nisi pharetra, in varius turpis volutpat. Curabitur sodales turpis ut neque elementum varius.\r\n\r\nDuis ullamcorper ornare condimentum. Integer mattis id ante in luctus. Curabitur at consectetur mi. Ut feugiat, purus quis lobortis fringilla, urna orci finibus diam, in maximus ligula enim nec magna. Duis ullamcorper augue dui, vitae dignissim ligula semper eget. Donec augue erat, posuere malesuada neque sed, porttitor fringilla sapien. Nunc id lectus nibh.'),(43,26,'_sections_1_text','field_5c861edcbfe06'),(44,26,'sections','a:2:{i:0;s:6:\"header\";i:1;s:9:\"paragraph\";}'),(45,26,'_sections','field_5c861e95bfe02'),(46,27,'sections_0_header','A bold header!'),(47,27,'_sections_0_header','field_5c861ea8bfe03'),(48,27,'sections_0_header_size','h1'),(49,27,'_sections_0_header_size','field_5c861eb9bfe04'),(50,27,'sections_1_text','Lorem ipsum dolor sit amet, consectetur adipiscing elit. <a href=\"http://www.google.se\">Donec tincidunt non turpis sit amet semper</a>. Nullam lobortis scelerisque dignissim. Sed convallis imperdiet leo, sed viverra risus cursus eu. Sed arcu metus, sagittis a semper ac, posuere eget nulla. Nullam ac mollis dolor, eget pulvinar enim. Donec sodales nisl ut eleifend auctor. Etiam quis aliquam eros.\r\nPhasellus vitae neque nec mi tincidunt pretium sed sed quam. Suspendisse condimentum nibh sed nisi pharetra, in varius turpis volutpat. Curabitur sodales turpis ut neque elementum varius.\r\n\r\nDuis ullamcorper ornare condimentum. Integer mattis id ante in luctus. Curabitur at consectetur mi. Ut feugiat, purus quis lobortis fringilla, urna orci finibus diam, in maximus ligula enim nec magna. Duis ullamcorper augue dui, vitae dignissim ligula semper eget. Donec augue erat, posuere malesuada neque sed, porttitor fringilla sapien. Nunc id lectus nibh.'),(51,27,'_sections_1_text','field_5c861edcbfe06'),(52,27,'sections','a:2:{i:0;s:6:\"header\";i:1;s:9:\"paragraph\";}'),(53,27,'_sections','field_5c861e95bfe02'),(54,28,'_edit_last','1'),(55,28,'_edit_lock','1552297284:1'),(56,28,'sections_0_header','Header for my child page'),(57,28,'_sections_0_header','field_5c861ea8bfe03'),(58,28,'sections_0_header_size','h2'),(59,28,'_sections_0_header_size','field_5c861eb9bfe04'),(60,28,'sections','a:1:{i:0;s:6:\"header\";}'),(61,28,'_sections','field_5c861e95bfe02'),(62,29,'sections_0_header','Header for my child page'),(63,29,'_sections_0_header','field_5c861ea8bfe03'),(64,29,'sections_0_header_size','h2'),(65,29,'_sections_0_header_size','field_5c861eb9bfe04'),(66,29,'sections','a:1:{i:0;s:6:\"header\";}'),(67,29,'_sections','field_5c861e95bfe02'),(68,30,'_edit_last','1'),(69,30,'sections',''),(70,30,'_sections','field_5c861e95bfe02'),(71,31,'sections',''),(72,31,'_sections','field_5c861e95bfe02'),(73,30,'_edit_lock','1552297819:1'),(74,32,'_edit_last','1'),(75,32,'_edit_lock','1552309215:1'),(76,36,'_edit_last','1'),(77,36,'_edit_lock','1552298473:1'),(78,36,'part_number','001'),(79,36,'_part_number','field_5c863254f925b'),(80,36,'description','A red part'),(81,36,'_description','field_5c86325af925c'),(82,36,'price','1000'),(83,36,'_price','field_5c863260f925d'),(84,37,'_edit_last','1'),(85,37,'part_number','002'),(86,37,'_part_number','field_5c863254f925b'),(87,37,'description','A blue part'),(88,37,'_description','field_5c86325af925c'),(89,37,'price','2000'),(90,37,'_price','field_5c863260f925d'),(91,37,'_edit_lock','1552298484:1'),(92,25,'sections_2_products','a:2:{i:0;s:2:\"36\";i:1;s:2:\"37\";}'),(93,25,'_sections_2_products','field_5c8632a299d3a'),(94,39,'sections_0_header','A bold header!'),(95,39,'_sections_0_header','field_5c861ea8bfe03'),(96,39,'sections_0_header_size','h1'),(97,39,'_sections_0_header_size','field_5c861eb9bfe04'),(98,39,'sections_1_text','Lorem ipsum dolor sit amet, consectetur adipiscing elit. <a href=\"http://www.google.se\">Donec tincidunt non turpis sit amet semper</a>. Nullam lobortis scelerisque dignissim. Sed convallis imperdiet leo, sed viverra risus cursus eu. Sed arcu metus, sagittis a semper ac, posuere eget nulla. Nullam ac mollis dolor, eget pulvinar enim. Donec sodales nisl ut eleifend auctor. Etiam quis aliquam eros.\r\nPhasellus vitae neque nec mi tincidunt pretium sed sed quam. Suspendisse condimentum nibh sed nisi pharetra, in varius turpis volutpat. Curabitur sodales turpis ut neque elementum varius.\r\n\r\nDuis ullamcorper ornare condimentum. Integer mattis id ante in luctus. Curabitur at consectetur mi. Ut feugiat, purus quis lobortis fringilla, urna orci finibus diam, in maximus ligula enim nec magna. Duis ullamcorper augue dui, vitae dignissim ligula semper eget. Donec augue erat, posuere malesuada neque sed, porttitor fringilla sapien. Nunc id lectus nibh.'),(99,39,'_sections_1_text','field_5c861edcbfe06'),(100,39,'sections','a:3:{i:0;s:6:\"header\";i:1;s:9:\"paragraph\";i:2;s:12:\"product_list\";}'),(101,39,'_sections','field_5c861e95bfe02'),(102,39,'sections_2_products','a:2:{i:0;s:2:\"36\";i:1;s:2:\"37\";}'),(103,39,'_sections_2_products','field_5c8632a299d3a'),(104,40,'sections_0_header','A bold header!'),(105,40,'_sections_0_header','field_5c861ea8bfe03'),(106,40,'sections_0_header_size','h1'),(107,40,'_sections_0_header_size','field_5c861eb9bfe04'),(108,40,'sections_1_text','paragraf 1\r\n\r\nparagraf 2\r\nrad 2'),(109,40,'_sections_1_text','field_5c861edcbfe06'),(110,40,'sections','a:3:{i:0;s:6:\"header\";i:1;s:9:\"paragraph\";i:2;s:12:\"product_list\";}'),(111,40,'_sections','field_5c861e95bfe02'),(112,40,'sections_2_products','a:2:{i:0;s:2:\"36\";i:1;s:2:\"37\";}'),(113,40,'_sections_2_products','field_5c8632a299d3a'),(114,25,'sections_3_product','a:2:{i:0;s:2:\"37\";i:1;s:2:\"36\";}'),(115,25,'_sections_3_product','field_5c8659dc3a036'),(116,42,'sections_0_header','A bold header!'),(117,42,'_sections_0_header','field_5c861ea8bfe03'),(118,42,'sections_0_header_size','h1'),(119,42,'_sections_0_header_size','field_5c861eb9bfe04'),(120,42,'sections_1_text','paragraf 1\r\n\r\nparagraf 2\r\nrad 2'),(121,42,'_sections_1_text','field_5c861edcbfe06'),(122,42,'sections','a:4:{i:0;s:6:\"header\";i:1;s:9:\"paragraph\";i:2;s:12:\"product_list\";i:3;s:14:\"single_product\";}'),(123,42,'_sections','field_5c861e95bfe02'),(124,42,'sections_2_products','a:2:{i:0;s:2:\"36\";i:1;s:2:\"37\";}'),(125,42,'_sections_2_products','field_5c8632a299d3a'),(126,42,'sections_3_product','37'),(127,42,'_sections_3_product','field_5c8659dc3a036'),(128,43,'sections_0_header','A bold header!'),(129,43,'_sections_0_header','field_5c861ea8bfe03'),(130,43,'sections_0_header_size','h1'),(131,43,'_sections_0_header_size','field_5c861eb9bfe04'),(132,43,'sections_1_text','paragraf 1\r\n\r\nparagraf 2\r\nrad 2'),(133,43,'_sections_1_text','field_5c861edcbfe06'),(134,43,'sections','a:4:{i:0;s:6:\"header\";i:1;s:9:\"paragraph\";i:2;s:12:\"product_list\";i:3;s:14:\"single_product\";}'),(135,43,'_sections','field_5c861e95bfe02'),(136,43,'sections_2_products','a:2:{i:0;s:2:\"36\";i:1;s:2:\"37\";}'),(137,43,'_sections_2_products','field_5c8632a299d3a'),(138,43,'sections_3_product','a:1:{i:0;s:2:\"37\";}'),(139,43,'_sections_3_product','field_5c8659dc3a036'),(140,44,'sections_0_header','A bold header!'),(141,44,'_sections_0_header','field_5c861ea8bfe03'),(142,44,'sections_0_header_size','h1'),(143,44,'_sections_0_header_size','field_5c861eb9bfe04'),(144,44,'sections_1_text','paragraf 1\r\n\r\nparagraf 2\r\nrad 2'),(145,44,'_sections_1_text','field_5c861edcbfe06'),(146,44,'sections','a:4:{i:0;s:6:\"header\";i:1;s:9:\"paragraph\";i:2;s:12:\"product_list\";i:3;s:14:\"single_product\";}'),(147,44,'_sections','field_5c861e95bfe02'),(148,44,'sections_2_products','a:2:{i:0;s:2:\"36\";i:1;s:2:\"37\";}'),(149,44,'_sections_2_products','field_5c8632a299d3a'),(150,44,'sections_3_product','a:2:{i:0;s:2:\"37\";i:1;s:2:\"36\";}'),(151,44,'_sections_3_product','field_5c8659dc3a036');
/*!40000 ALTER TABLE `wp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_posts`
--

LOCK TABLES `wp_posts` WRITE;
/*!40000 ALTER TABLE `wp_posts` DISABLE KEYS */;
INSERT INTO `wp_posts` VALUES (7,1,'2019-03-11 08:36:33','0000-00-00 00:00:00','','Auto Draft','','auto-draft','closed','open','','','','','2019-03-11 08:36:33','0000-00-00 00:00:00','',0,'http://0.0.0.0:9090/?p=7',0,'post','',0),(8,1,'2019-03-11 08:36:46','2019-03-11 08:36:46','a:9:{s:8:\"location\";a:1:{i:0;a:1:{i:0;a:3:{s:5:\"param\";s:9:\"post_type\";s:8:\"operator\";s:2:\"==\";s:5:\"value\";s:4:\"page\";}}}s:8:\"position\";s:6:\"normal\";s:5:\"style\";s:7:\"default\";s:15:\"label_placement\";s:3:\"top\";s:21:\"instruction_placement\";s:5:\"label\";s:14:\"hide_on_screen\";a:5:{i:0;s:11:\"the_content\";i:1;s:7:\"excerpt\";i:2;s:10:\"discussion\";i:3;s:8:\"comments\";i:4;s:15:\"send-trackbacks\";}s:11:\"description\";s:0:\"\";s:8:\"modified\";i:1548666396;s:5:\"local\";s:4:\"json\";}','Page sections','page-sections','trash','closed','closed','','group_5c4ec50d044b0__trashed','','','2019-03-11 08:42:14','2019-03-11 08:42:14','',0,'http://0.0.0.0:9090/?post_type=acf-field-group&#038;p=8',0,'acf-field-group','',0),(13,1,'2019-03-11 08:37:52','2019-03-11 08:37:52','a:9:{s:4:\"type\";s:16:\"flexible_content\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:7:\"layouts\";a:1:{s:13:\"5c4ec5a7c5cbc\";a:6:{s:3:\"key\";s:13:\"5c4ec5a7c5cbc\";s:4:\"name\";s:7:\"example\";s:5:\"label\";s:7:\"Example\";s:7:\"display\";s:5:\"block\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";}}s:12:\"button_label\";s:11:\"Add section\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";}','Sections','sections','publish','closed','closed','','field_5c4ec55bccac1','','','2019-03-11 08:37:52','2019-03-11 08:37:52','',0,'http://0.0.0.0:9090/?post_type=acf-field&p=13',0,'acf-field','',0),(14,1,'2019-03-11 08:37:52','2019-03-11 08:37:52','a:11:{s:4:\"type\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"default_value\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";s:7:\"prepend\";s:0:\"\";s:6:\"append\";s:0:\"\";s:9:\"maxlength\";s:0:\"\";s:13:\"parent_layout\";s:13:\"5c4ec5a7c5cbc\";}','The text','the_text','publish','closed','closed','','field_5c4ec5b9ccac2','','','2019-03-11 08:37:52','2019-03-11 08:37:52','',13,'http://0.0.0.0:9090/?post_type=acf-field&p=14',0,'acf-field','',0),(15,1,'2019-03-11 08:37:52','2019-03-11 08:37:52','a:9:{s:8:\"location\";a:1:{i:0;a:1:{i:0;a:3:{s:5:\"param\";s:12:\"options_page\";s:8:\"operator\";s:2:\"==\";s:5:\"value\";s:7:\"globals\";}}}s:8:\"position\";s:6:\"normal\";s:5:\"style\";s:7:\"default\";s:15:\"label_placement\";s:3:\"top\";s:21:\"instruction_placement\";s:5:\"label\";s:14:\"hide_on_screen\";s:0:\"\";s:11:\"description\";s:0:\"\";s:8:\"modified\";i:1548666088;s:5:\"local\";s:4:\"json\";}','Site options','site-options','publish','closed','closed','','group_5c4ec4834133b','','','2019-03-11 08:37:52','2019-03-11 08:37:52','',0,'http://0.0.0.0:9090/?post_type=acf-field-group&p=15',0,'acf-field-group','',0),(16,1,'2019-03-11 08:37:52','2019-03-11 08:37:52','a:10:{s:4:\"type\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"default_value\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";s:7:\"prepend\";s:0:\"\";s:6:\"append\";s:0:\"\";s:9:\"maxlength\";s:0:\"\";}','Google analytics ID','google_analytics_id','publish','closed','closed','','field_5c4ec48b4e1aa','','','2019-03-11 08:37:52','2019-03-11 08:37:52','',15,'http://0.0.0.0:9090/?post_type=acf-field&p=16',0,'acf-field','',0),(17,1,'2019-03-11 08:40:57','2019-03-11 08:40:57','a:7:{s:8:\"location\";a:1:{i:0;a:1:{i:0;a:3:{s:5:\"param\";s:9:\"post_type\";s:8:\"operator\";s:2:\"==\";s:5:\"value\";s:4:\"page\";}}}s:8:\"position\";s:6:\"normal\";s:5:\"style\";s:7:\"default\";s:15:\"label_placement\";s:3:\"top\";s:21:\"instruction_placement\";s:5:\"label\";s:14:\"hide_on_screen\";a:6:{i:0;s:11:\"the_content\";i:1;s:7:\"excerpt\";i:2;s:10:\"discussion\";i:3;s:8:\"comments\";i:4;s:6:\"author\";i:5;s:15:\"send-trackbacks\";}s:11:\"description\";s:0:\"\";}','Sections','sections','publish','closed','closed','','group_5c861e9172bda','','','2019-03-11 13:08:02','2019-03-11 13:08:02','',0,'http://0.0.0.0:9090/?post_type=acf-field-group&#038;p=17',0,'acf-field-group','',0),(18,1,'2019-03-11 08:40:57','2019-03-11 08:40:57','a:9:{s:4:\"type\";s:16:\"flexible_content\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:7:\"layouts\";a:4:{s:13:\"5c861e99d3fcb\";a:6:{s:3:\"key\";s:13:\"5c861e99d3fcb\";s:5:\"label\";s:6:\"Header\";s:4:\"name\";s:6:\"header\";s:7:\"display\";s:5:\"block\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";}s:20:\"layout_5c861ed2bfe05\";a:6:{s:3:\"key\";s:20:\"layout_5c861ed2bfe05\";s:5:\"label\";s:9:\"Paragraph\";s:4:\"name\";s:9:\"paragraph\";s:7:\"display\";s:5:\"block\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";}s:20:\"layout_5c86329999d39\";a:6:{s:3:\"key\";s:20:\"layout_5c86329999d39\";s:5:\"label\";s:12:\"Product list\";s:4:\"name\";s:12:\"product_list\";s:7:\"display\";s:5:\"block\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";}s:20:\"layout_5c8659d63a035\";a:6:{s:3:\"key\";s:20:\"layout_5c8659d63a035\";s:5:\"label\";s:14:\"Single product\";s:4:\"name\";s:14:\"single_product\";s:7:\"display\";s:5:\"block\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";}}s:12:\"button_label\";s:11:\"Add Section\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";}','Page sections','sections','publish','closed','closed','','field_5c861e95bfe02','','','2019-03-11 12:52:23','2019-03-11 12:52:23','',17,'http://0.0.0.0:9090/?post_type=acf-field&#038;p=18',0,'acf-field','',0),(19,1,'2019-03-11 08:40:57','2019-03-11 08:40:57','a:11:{s:4:\"type\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"parent_layout\";s:13:\"5c861e99d3fcb\";s:13:\"default_value\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";s:7:\"prepend\";s:0:\"\";s:6:\"append\";s:0:\"\";s:9:\"maxlength\";s:0:\"\";}','Header','header','publish','closed','closed','','field_5c861ea8bfe03','','','2019-03-11 08:40:57','2019-03-11 08:40:57','',18,'http://0.0.0.0:9090/?post_type=acf-field&p=19',0,'acf-field','',0),(20,1,'2019-03-11 08:40:57','2019-03-11 08:40:57','a:14:{s:4:\"type\";s:6:\"select\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"parent_layout\";s:13:\"5c861e99d3fcb\";s:7:\"choices\";a:2:{s:2:\"h1\";s:2:\"H1\";s:2:\"h2\";s:2:\"H2\";}s:13:\"default_value\";a:0:{}s:10:\"allow_null\";i:0;s:8:\"multiple\";i:0;s:2:\"ui\";i:0;s:13:\"return_format\";s:5:\"value\";s:4:\"ajax\";i:0;s:11:\"placeholder\";s:0:\"\";}','Header size','header_size','publish','closed','closed','','field_5c861eb9bfe04','','','2019-03-11 08:40:57','2019-03-11 08:40:57','',18,'http://0.0.0.0:9090/?post_type=acf-field&p=20',1,'acf-field','',0),(21,1,'2019-03-11 08:40:57','2019-03-11 08:40:57','a:11:{s:4:\"type\";s:7:\"wysiwyg\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"parent_layout\";s:20:\"layout_5c861ed2bfe05\";s:13:\"default_value\";s:0:\"\";s:4:\"tabs\";s:3:\"all\";s:7:\"toolbar\";s:5:\"basic\";s:12:\"media_upload\";i:0;s:5:\"delay\";i:0;}','Text','text','publish','closed','closed','','field_5c861edcbfe06','','','2019-03-11 08:40:57','2019-03-11 08:40:57','',18,'http://0.0.0.0:9090/?post_type=acf-field&p=21',0,'acf-field','',0),(22,1,'2019-03-11 08:41:12','0000-00-00 00:00:00','','Auto Draft','','auto-draft','closed','closed','','','','','2019-03-11 08:41:12','0000-00-00 00:00:00','',0,'http://0.0.0.0:9090/?page_id=22',0,'page','',0),(23,1,'2019-03-11 08:41:33','0000-00-00 00:00:00','','Auto Draft','','auto-draft','closed','closed','','','','','2019-03-11 08:41:33','0000-00-00 00:00:00','',0,'http://0.0.0.0:9090/?page_id=23',0,'page','',0),(24,1,'2019-03-11 08:42:03','0000-00-00 00:00:00','','Auto Draft','','auto-draft','closed','closed','','','','','2019-03-11 08:42:03','0000-00-00 00:00:00','',0,'http://0.0.0.0:9090/?page_id=24',0,'page','',0),(25,1,'2019-03-11 08:43:09','2019-03-11 08:43:09','','My first page','','publish','closed','closed','','my-first-page','','','2019-03-11 13:08:07','2019-03-11 13:08:07','',0,'http://0.0.0.0:9090/?page_id=25',0,'page','',0),(26,1,'2019-03-11 08:43:09','2019-03-11 08:43:09','','My first page','','inherit','closed','closed','','25-revision-v1','','','2019-03-11 08:43:09','2019-03-11 08:43:09','',25,'http://0.0.0.0:9090/?p=26',0,'revision','',0),(27,1,'2019-03-11 09:04:05','2019-03-11 09:04:05','','My first page','','inherit','closed','closed','','25-revision-v1','','','2019-03-11 09:04:05','2019-03-11 09:04:05','',25,'http://0.0.0.0:9090/index.php/25-revision-v1/',0,'revision','',0),(28,1,'2019-03-11 09:41:24','2019-03-11 09:41:24','','My child page','','publish','closed','closed','','my-child-page','','','2019-03-11 09:41:24','2019-03-11 09:41:24','',25,'http://0.0.0.0:9090/?page_id=28',0,'page','',0),(29,1,'2019-03-11 09:41:24','2019-03-11 09:41:24','','My child page','','inherit','closed','closed','','28-revision-v1','','','2019-03-11 09:41:24','2019-03-11 09:41:24','',28,'http://0.0.0.0:9090/index.php/28-revision-v1/',0,'revision','',0),(30,1,'2019-03-11 09:52:06','2019-03-11 09:52:06','','My startpage','','publish','closed','closed','','my-startpage','','','2019-03-11 09:52:06','2019-03-11 09:52:06','',0,'http://0.0.0.0:9090/?page_id=30',0,'page','',0),(31,1,'2019-03-11 09:52:06','2019-03-11 09:52:06','','My startpage','','inherit','closed','closed','','30-revision-v1','','','2019-03-11 09:52:06','2019-03-11 09:52:06','',30,'http://0.0.0.0:9090/index.php/30-revision-v1/',0,'revision','',0),(32,1,'2019-03-11 10:03:16','2019-03-11 10:03:16','a:7:{s:8:\"location\";a:1:{i:0;a:1:{i:0;a:3:{s:5:\"param\";s:9:\"post_type\";s:8:\"operator\";s:2:\"==\";s:5:\"value\";s:12:\"acme_product\";}}}s:8:\"position\";s:6:\"normal\";s:5:\"style\";s:7:\"default\";s:15:\"label_placement\";s:3:\"top\";s:21:\"instruction_placement\";s:5:\"label\";s:14:\"hide_on_screen\";s:0:\"\";s:11:\"description\";s:0:\"\";}','Product','product','publish','closed','closed','','group_5c86324f9aebd','','','2019-03-11 10:03:16','2019-03-11 10:03:16','',0,'http://0.0.0.0:9090/?post_type=acf-field-group&#038;p=32',0,'acf-field-group','',0),(33,1,'2019-03-11 10:03:16','2019-03-11 10:03:16','a:10:{s:4:\"type\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"default_value\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";s:7:\"prepend\";s:0:\"\";s:6:\"append\";s:0:\"\";s:9:\"maxlength\";s:0:\"\";}','Part number','part_number','publish','closed','closed','','field_5c863254f925b','','','2019-03-11 10:03:16','2019-03-11 10:03:16','',32,'http://0.0.0.0:9090/?post_type=acf-field&p=33',0,'acf-field','',0),(34,1,'2019-03-11 10:03:16','2019-03-11 10:03:16','a:10:{s:4:\"type\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"default_value\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";s:7:\"prepend\";s:0:\"\";s:6:\"append\";s:0:\"\";s:9:\"maxlength\";s:0:\"\";}','Description','description','publish','closed','closed','','field_5c86325af925c','','','2019-03-11 10:03:16','2019-03-11 10:03:16','',32,'http://0.0.0.0:9090/?post_type=acf-field&p=34',1,'acf-field','',0),(35,1,'2019-03-11 10:03:16','2019-03-11 10:03:16','a:10:{s:4:\"type\";s:4:\"text\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"default_value\";s:0:\"\";s:11:\"placeholder\";s:0:\"\";s:7:\"prepend\";s:0:\"\";s:6:\"append\";s:0:\"\";s:9:\"maxlength\";s:0:\"\";}','Price','price','publish','closed','closed','','field_5c863260f925d','','','2019-03-11 10:03:16','2019-03-11 10:03:16','',32,'http://0.0.0.0:9090/?post_type=acf-field&p=35',2,'acf-field','',0),(36,1,'2019-03-11 10:03:35','2019-03-11 10:03:35','','Product A','','publish','closed','closed','','product-a','','','2019-03-11 10:03:35','2019-03-11 10:03:35','',0,'http://0.0.0.0:9090/?post_type=acme_product&#038;p=36',0,'acme_product','',0),(37,1,'2019-03-11 10:03:47','2019-03-11 10:03:47','','Product B','','publish','closed','closed','','product-b','','','2019-03-11 10:03:47','2019-03-11 10:03:47','',0,'http://0.0.0.0:9090/?post_type=acme_product&#038;p=37',0,'acme_product','',0),(38,1,'2019-03-11 10:04:56','2019-03-11 10:04:56','a:13:{s:4:\"type\";s:12:\"relationship\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"parent_layout\";s:20:\"layout_5c86329999d39\";s:9:\"post_type\";a:1:{i:0;s:12:\"acme_product\";}s:8:\"taxonomy\";s:0:\"\";s:7:\"filters\";a:3:{i:0;s:6:\"search\";i:1;s:9:\"post_type\";i:2;s:8:\"taxonomy\";}s:8:\"elements\";s:0:\"\";s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";s:13:\"return_format\";s:2:\"id\";}','Products','products','publish','closed','closed','','field_5c8632a299d3a','','','2019-03-11 13:08:02','2019-03-11 13:08:02','',18,'http://0.0.0.0:9090/?post_type=acf-field&#038;p=38',0,'acf-field','',0),(39,1,'2019-03-11 10:05:11','2019-03-11 10:05:11','','My first page','','inherit','closed','closed','','25-revision-v1','','','2019-03-11 10:05:11','2019-03-11 10:05:11','',25,'http://0.0.0.0:9090/index.php/25-revision-v1/',0,'revision','',0),(40,1,'2019-03-11 10:29:56','2019-03-11 10:29:56','','My first page','','inherit','closed','closed','','25-revision-v1','','','2019-03-11 10:29:56','2019-03-11 10:29:56','',25,'http://0.0.0.0:9090/index.php/25-revision-v1/',0,'revision','',0),(41,1,'2019-03-11 12:52:23','2019-03-11 12:52:23','a:12:{s:4:\"type\";s:11:\"post_object\";s:12:\"instructions\";s:0:\"\";s:8:\"required\";i:0;s:17:\"conditional_logic\";i:0;s:7:\"wrapper\";a:3:{s:5:\"width\";s:0:\"\";s:5:\"class\";s:0:\"\";s:2:\"id\";s:0:\"\";}s:13:\"parent_layout\";s:20:\"layout_5c8659d63a035\";s:9:\"post_type\";a:1:{i:0;s:12:\"acme_product\";}s:8:\"taxonomy\";s:0:\"\";s:10:\"allow_null\";i:0;s:8:\"multiple\";i:1;s:13:\"return_format\";s:2:\"id\";s:2:\"ui\";i:1;}','Product','product','publish','closed','closed','','field_5c8659dc3a036','','','2019-03-11 12:56:37','2019-03-11 12:56:37','',18,'http://0.0.0.0:9090/?post_type=acf-field&#038;p=41',0,'acf-field','',0),(42,1,'2019-03-11 12:52:39','2019-03-11 12:52:39','','My first page','','inherit','closed','closed','','25-revision-v1','','','2019-03-11 12:52:39','2019-03-11 12:52:39','',25,'http://0.0.0.0:9090/index.php/25-revision-v1/',0,'revision','',0),(43,1,'2019-03-11 12:56:55','2019-03-11 12:56:55','','My first page','','inherit','closed','closed','','25-revision-v1','','','2019-03-11 12:56:55','2019-03-11 12:56:55','',25,'http://0.0.0.0:9090/index.php/25-revision-v1/',0,'revision','',0),(44,1,'2019-03-11 13:00:51','2019-03-11 13:00:51','','My first page','','inherit','closed','closed','','25-revision-v1','','','2019-03-11 13:00:51','2019-03-11 13:00:51','',25,'http://0.0.0.0:9090/index.php/25-revision-v1/',0,'revision','',0);
/*!40000 ALTER TABLE `wp_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_relationships`
--

LOCK TABLES `wp_term_relationships` WRITE;
/*!40000 ALTER TABLE `wp_term_relationships` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_taxonomy`
--

LOCK TABLES `wp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `wp_term_taxonomy` DISABLE KEYS */;
INSERT INTO `wp_term_taxonomy` VALUES (1,1,'category','',0,0);
/*!40000 ALTER TABLE `wp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_termmeta`
--

LOCK TABLES `wp_termmeta` WRITE;
/*!40000 ALTER TABLE `wp_termmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_terms`
--

LOCK TABLES `wp_terms` WRITE;
/*!40000 ALTER TABLE `wp_terms` DISABLE KEYS */;
INSERT INTO `wp_terms` VALUES (1,'Uncategorized','uncategorized',0);
/*!40000 ALTER TABLE `wp_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_usermeta`
--

LOCK TABLES `wp_usermeta` WRITE;
/*!40000 ALTER TABLE `wp_usermeta` DISABLE KEYS */;
INSERT INTO `wp_usermeta` VALUES (1,1,'nickname','admin'),(2,1,'first_name',''),(3,1,'last_name',''),(4,1,'description',''),(5,1,'rich_editing','true'),(6,1,'comment_shortcuts','false'),(7,1,'admin_color','fresh'),(8,1,'use_ssl','0'),(9,1,'show_admin_bar_front','true'),(10,1,'locale',''),(11,1,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}'),(12,1,'wp_user_level','10'),(13,1,'dismissed_wp_pointers',''),(14,1,'show_welcome_panel','0'),(16,1,'wp_dashboard_quick_press_last_post_id','3'),(17,1,'community-events-location','a:1:{s:2:\"ip\";s:9:\"127.0.0.0\";}'),(18,1,'session_tokens','a:1:{s:64:\"d61ab8a4d59182025365e69cf529bafea8ceacbfc52896c6706e71ec0703a20c\";a:4:{s:10:\"expiration\";i:1552466192;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:121:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36\";s:5:\"login\";i:1552293392;}}'),(19,1,'closedpostboxes_dashboard','a:0:{}'),(20,1,'metaboxhidden_dashboard','a:2:{i:0;s:21:\"dashboard_quick_press\";i:1;s:17:\"dashboard_primary\";}'),(21,1,'meta-box-order_dashboard','a:4:{s:6:\"normal\";s:38:\"dashboard_right_now,dashboard_activity\";s:4:\"side\";s:39:\"dashboard_quick_press,dashboard_primary\";s:7:\"column3\";s:0:\"\";s:7:\"column4\";s:0:\"\";}'),(22,1,'closedpostboxes_page','a:0:{}'),(23,1,'metaboxhidden_page','a:3:{i:0;s:23:\"acf-group_5c4ec4834133b\";i:1;s:7:\"slugdiv\";i:2;s:9:\"authordiv\";}'),(24,1,'wp_user-settings','editor=tinymce'),(25,1,'wp_user-settings-time','1552295041');
/*!40000 ALTER TABLE `wp_usermeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_users`
--

LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
INSERT INTO `wp_users` VALUES (1,'admin','$P$B2cWu/Mrlh/2X.k05MKLe29FwLdnhr.','admin','wptemplate@studioakademi.com','','2017-08-14 09:03:37','',0,'admin');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-11 14:08:34

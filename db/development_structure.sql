CREATE TABLE `audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auditable_id` int(11) DEFAULT NULL,
  `auditable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'update',
  `details` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_audits_on_auditable_id` (`auditable_id`),
  KEY `index_audits_on_auditable_type` (`auditable_type`),
  KEY `index_audits_on_auditable_type_and_auditable_id` (`auditable_type`,`auditable_id`),
  KEY `index_audits_on_member_id` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=695 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` text COLLATE utf8_unicode_ci,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accepts_image` tinyint(1) DEFAULT '0',
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_updated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_blocks_on_label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `duration` int(11) DEFAULT '1',
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_updated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_events_on_member_id` (`member_id`),
  KEY `index_events_on_permalink` (`permalink`),
  KEY `index_events_on_created_at` (`created_at`),
  KEY `index_events_on_starts_at` (`starts_at`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `executives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_executives_on_member_id` (`member_id`),
  KEY `index_executives_on_sort_order` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_links_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `mailing_list_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mailing_list_entries_on_ip_address` (`ip_address`),
  KEY `index_mailing_list_entries_on_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8_unicode_ci,
  `receive_emails` tinyint(1) DEFAULT '1',
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_updated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `crypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `persistence_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `current_login_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `password_configured` tinyint(1) DEFAULT '0',
  `last_request_at` datetime DEFAULT NULL,
  `alternate_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `legacy_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `secret_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `legacy_username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact_method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `renting` tinyint(1) DEFAULT '1',
  `subletting_member_id` int(11) DEFAULT NULL,
  `space_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `perishable_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `member_since_year` int(11) DEFAULT NULL,
  `member_since_month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_members_on_email` (`email`),
  UNIQUE KEY `index_members_on_persistence_token` (`persistence_token`),
  KEY `index_members_on_receive_emails` (`receive_emails`),
  KEY `index_members_on_permalink` (`permalink`),
  KEY `index_members_on_admin` (`admin`),
  KEY `index_members_on_active` (`active`),
  KEY `index_members_on_password_configured` (`password_configured`),
  KEY `index_members_on_legacy_name` (`legacy_name`),
  KEY `index_members_on_renting` (`renting`),
  KEY `index_members_on_subletting_member_id` (`subletting_member_id`),
  KEY `index_members_on_perishable_token` (`perishable_token`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `pending_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locals` text COLLATE utf8_unicode_ci,
  `processing` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pending_emails_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `pictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_updated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pictures_on_member_id` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_updated_at` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_posts_on_member_id` (`member_id`),
  KEY `index_posts_on_permalink` (`permalink`),
  KEY `index_posts_on_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `system_variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20101201031658');

INSERT INTO schema_migrations (version) VALUES ('20101201145429');

INSERT INTO schema_migrations (version) VALUES ('20101202162408');

INSERT INTO schema_migrations (version) VALUES ('20101202163754');

INSERT INTO schema_migrations (version) VALUES ('20101202170428');

INSERT INTO schema_migrations (version) VALUES ('20101202211202');

INSERT INTO schema_migrations (version) VALUES ('20101204022409');

INSERT INTO schema_migrations (version) VALUES ('20110508142839');

INSERT INTO schema_migrations (version) VALUES ('20110518164702');

INSERT INTO schema_migrations (version) VALUES ('20110520011720');

INSERT INTO schema_migrations (version) VALUES ('20110520023652');

INSERT INTO schema_migrations (version) VALUES ('20110520124437');

INSERT INTO schema_migrations (version) VALUES ('20110520185141');

INSERT INTO schema_migrations (version) VALUES ('20110521211708');

INSERT INTO schema_migrations (version) VALUES ('20110525190247');

INSERT INTO schema_migrations (version) VALUES ('20110602032733');

INSERT INTO schema_migrations (version) VALUES ('20110606132704');

INSERT INTO schema_migrations (version) VALUES ('20110606133848');

INSERT INTO schema_migrations (version) VALUES ('20110606235715');

INSERT INTO schema_migrations (version) VALUES ('20110611021509');

INSERT INTO schema_migrations (version) VALUES ('20110614184802');

INSERT INTO schema_migrations (version) VALUES ('20110619135115');

INSERT INTO schema_migrations (version) VALUES ('20110923163704');

INSERT INTO schema_migrations (version) VALUES ('20110925220520');

INSERT INTO schema_migrations (version) VALUES ('20110926202028');

INSERT INTO schema_migrations (version) VALUES ('20110927040407');

INSERT INTO schema_migrations (version) VALUES ('20111014002500');

INSERT INTO schema_migrations (version) VALUES ('20111030185204');

INSERT INTO schema_migrations (version) VALUES ('20120326011159');
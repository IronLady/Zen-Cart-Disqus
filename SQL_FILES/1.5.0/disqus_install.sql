INSERT INTO configuration_group (`configuration_group_title`,`configuration_group_description`,`sort_order`,`visible`) VALUES ('Disqus Comments', 'Disqus Comments Configuration', '1', '1');
UPDATE configuration_group SET sort_order = last_insert_id() WHERE configuration_group_id = last_insert_id();

SET @t4=0;
SELECT (@t4:=configuration_group_id) as t4 
FROM configuration_group
WHERE configuration_group_title= 'Disqus Comments';

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES 
('Enable Disqus', 'DISQUS_STATUS', 'true', 'Turn On/Off Disqus Comments System', @t4, 1, NOW(), NOW(), NULL, 'zen_cfg_select_option(array(\'true\', \'false\'),'),
('Site Shortname', 'DISQUS_SHORTNAME', '', 'Your Disqus Site Shortname. Sign Up <a href="http://disqus.com/" target="_blank">here</a> if you don\'t have it yet.', @t4, 2, NOW(), NOW(), NULL, NULL),
('Element ID', 'DISQUS_ELEMENT_ID', 'disqus_thread', 'Disqus HTML Element ID, this the place where disqus appear. Default is "disqus_thread"', @t4, 3, NOW(), NOW(), NULL, NULL);

INSERT INTO admin_pages (page_key, language_key, main_page, page_params, menu_key, display_on_menu, sort_order) VALUES ('configDisqus', 'BOX_CONFIGURATION_DISQUS', 'FILENAME_CONFIGURATION', CONCAT('gID=',@t4), 'configuration', 'Y', 100);

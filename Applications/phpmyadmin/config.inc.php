<?php

/* vim: set expandtab sw=4 ts=4 sts=4: */
/**
 * phpMyAdmin sample configuration, you can use it as base for
 * manual configuration. For easier setup you can use setup/
 *
 * All directives are explained in documentation in the doc/ folder
 * or at <http://docs.phpmyadmin.net/>.
 *
 * @package PhpMyAdmin
 */
/**
 * This is needed for cookie based authentication to encrypt password in
 * cookie
 */
$cfg['blowfish_secret'] = 'SECRET'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */
$cfg['PmaNoRelation_DisableWarning'] = true;

/**
 * Servers configuration
 */
$i = 0;

/**
 * First server
 */
if(getenv('MARIADB_ENV_MYSQL_USER') != '') {
    $i++;
    $cfg['Servers'][$i]['extension'] = 'mysqli';
    $cfg['Servers'][$i]['auth_type'] = 'config';
    $cfg['Servers'][$i]['host'] = getenv('MARIADB_PORT_3306_TCP_ADDR');
    $cfg['Servers'][$i]['port'] = getenv('MARIADB_PORT_3306_TCP_PORT');
    $cfg['Servers'][$i]['user'] = getenv('MARIADB_ENV_MYSQL_USER');
    $cfg['Servers'][$i]['password'] = getenv('MARIADB_ENV_MYSQL_PASSWORD');
    
}
if(getenv('MARIADB2_ENV_MYSQL_USER') != '') {
    $i++;
    $cfg['Servers'][$i]['extension'] = 'mysqli';
    $cfg['Servers'][$i]['auth_type'] = 'config';
    $cfg['Servers'][$i]['host'] = getenv('MARIADB2_PORT_3306_TCP_ADDR');
    $cfg['Servers'][$i]['port'] = getenv('MARIADB2_PORT_3306_TCP_PORT');
    $cfg['Servers'][$i]['user'] = getenv('MARIADB2_ENV_MYSQL_USER');
    $cfg['Servers'][$i]['password'] = getenv('MARIADB2_ENV_MYSQL_PASSWORD');
}
/**
 * phpMyAdmin configuration storage settings.
 */
/* User used to manipulate with storage */
// $cfg['Servers'][$i]['controlhost'] = '';
// $cfg['Servers'][$i]['controlport'] = '';
// $cfg['Servers'][$i]['controluser'] = 'pma';
// $cfg['Servers'][$i]['controlpass'] = 'pmapass';

/* Storage database and tables */
// $cfg['Servers'][$i]['pmadb'] = 'phpmyadmin';
// $cfg['Servers'][$i]['bookmarktable'] = 'pma__bookmark';
// $cfg['Servers'][$i]['relation'] = 'pma__relation';
// $cfg['Servers'][$i]['table_info'] = 'pma__table_info';
// $cfg['Servers'][$i]['table_coords'] = 'pma__table_coords';
// $cfg['Servers'][$i]['pdf_pages'] = 'pma__pdf_pages';
// $cfg['Servers'][$i]['column_info'] = 'pma__column_info';
// $cfg['Servers'][$i]['history'] = 'pma__history';
// $cfg['Servers'][$i]['table_uiprefs'] = 'pma__table_uiprefs';
// $cfg['Servers'][$i]['tracking'] = 'pma__tracking';
// $cfg['Servers'][$i]['userconfig'] = 'pma__userconfig';
// $cfg['Servers'][$i]['recent'] = 'pma__recent';
// $cfg['Servers'][$i]['favorite'] = 'pma__favorite';
// $cfg['Servers'][$i]['users'] = 'pma__users';
// $cfg['Servers'][$i]['usergroups'] = 'pma__usergroups';
// $cfg['Servers'][$i]['navigationhiding'] = 'pma__navigationhiding';
// $cfg['Servers'][$i]['savedsearches'] = 'pma__savedsearches';
// $cfg['Servers'][$i]['central_columns'] = 'pma__central_columns';
// $cfg['Servers'][$i]['designer_settings'] = 'pma__designer_settings';
// $cfg['Servers'][$i]['export_templates'] = 'pma__export_templates';
/* Contrib / Swekey authentication */
// $cfg['Servers'][$i]['auth_swekey_config'] = '/etc/swekey-pma.conf';

/**
 * End of servers configuration
 */
/**
 * Directories for saving/loading files from server
 */
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

/**
 * Whether to display icons or text or both icons and text in table row
 * action segment. Value can be either of 'icons', 'text' or 'both'.
 * default = 'both'
 */
//$cfg['RowActionType'] = 'icons';

/**
 * Defines whether a user should be displayed a "show all (records)"
 * button in browse mode or not.
 * default = false
 */
//$cfg['ShowAll'] = true;

/**
 * Number of rows displayed when browsing a result set. If the result
 * set contains more rows, "Previous" and "Next".
 * Possible values: 25, 50, 100, 250, 500
 * default = 25
 */
//$cfg['MaxRows'] = 50;

/**
 * Disallow editing of binary fields
 * valid values are:
 *   false    allow editing
 *   'blob'   allow editing except for BLOB fields
 *   'noblob' disallow editing except for BLOB fields
 *   'all'    disallow editing
 * default = 'blob'
 */
//$cfg['ProtectBinary'] = false;

/**
 * Default language to use, if not browser-defined or user-defined
 * (you find all languages in the locale folder)
 * uncomment the desired line:
 * default = 'en'
 */
//$cfg['DefaultLang'] = 'en';
//$cfg['DefaultLang'] = 'de';

/**
 * How many columns should be used for table display of a database?
 * (a value larger than 1 results in some information being hidden)
 * default = 1
 */
//$cfg['PropertiesNumColumns'] = 2;

/**
 * Set to true if you want DB-based query history.If false, this utilizes
 * JS-routines to display query history (lost by window close)
 *
 * This requires configuration storage enabled, see above.
 * default = false
 */
//$cfg['QueryHistoryDB'] = true;

/**
 * When using DB-based query history, how many entries should be kept?
 * default = 25
 */
//$cfg['QueryHistoryMax'] = 100;

/**
 * Whether or not to query the user before sending the error report to
 * the phpMyAdmin team when a JavaScript error occurs
 *
 * Available options
 * ('ask' | 'always' | 'never')
 * default = 'ask'
 */
//$cfg['SendErrorReports'] = 'always';

/**
 * You can find more configuration options in the documentation
 * in the doc/ folder or at <http://docs.phpmyadmin.net/>.
 */

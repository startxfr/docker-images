<?php
// fichier qui provient du container startx/app-pma
$cfg['blowfish_secret'] = 'SECRET';
$cfg['PmaNoRelation_DisableWarning'] = true;
$i = 0;
$i++;
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['host'] = 'mariadb';
$cfg['Servers'][$i]['controlhost'] = '';
$cfg['Servers'][$i]['controluser'] = 'root';
$cfg['Servers'][$i]['controlpass'] = 'secretdemerde';

?>

<?php
//konfigurasi server database
$host = 'mariadb';
$user = 'root';
$pass = 'Cpu25';
$debe = 'candysmk';
// $host = getenv('DB_HOST') ?: 'mariadb';
// $user = getenv('DB_USER') ?: 'root';
// $pass = getenv('DB_PASS') ?: 'Cpu25';
// $debe = getenv('DB_NAME') ?: 'candydb';

$koneksi = mysqli_connect($host, $user, $pass, "");
if ($koneksi) {
	$pilihdb = mysqli_select_db($koneksi, $debe);
	if ($pilihdb) {
		$query = mysqli_query($koneksi, "SELECT * FROM setting WHERE id_setting='1'");
		if ($query) {
			$setting = mysqli_fetch_array($query);
			mysqli_set_charset($koneksi, 'utf8');
			$sess = mysqli_fetch_array(mysqli_query($koneksi, "SELECT * FROM session WHERE id='1'"));
			date_default_timezone_set($setting['waktu']);
		}
	}
}

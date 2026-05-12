<?php
$db_host = getenv('DB_HOST') ?: 'db';
$db_user = getenv('DB_USER') ?: 'parkiruser';
$db_pass = getenv('DB_PASS') ?: 'parkirpass';
$db_name = getenv('DB_NAME') ?: 'parkir';
$db_port = getenv('DB_PORT') ?: 3306;

$koneksi = mysqli_connect(
    $db_host,
    $db_user,
    $db_pass,
    $db_name,
    $db_port
);

if (mysqli_connect_errno()){
    die("Koneksi database gagal: " . mysqli_connect_error());
}

function rupiah($angka)
{
    return number_format($angka, 0, ',', '.');
}

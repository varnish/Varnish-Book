<?php
if( isset( $_COOKIE ) && isset( $_COOKIE['user'] ) )
{
    echo "Hello " . $_COOKIE['user'];
}
else
{
    echo 'You did not provided any user cookie';
}
?>
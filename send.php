<?php

    use PHPMailer\PHPMailer\PHPMailer;

    require 'PHPMailer.php';
    require 'SMTP.php';
    include 'credentials.php';

    $mail             = new PHPMailer();

    $mail->IsSMTP(); // telling the class to use SMTP
    $mail->SMTPDebug  = 2;                     // enables SMTP debug information (for testing)
                                            // 1 = errors and messages
                                            // 2 = messages only
    $mail->SMTPAuth   = true;                  // enable SMTP authentication
    $mail->SMTPSecure = "tls";                 
    $mail->Host       = "smtp.gmail.com";      // SMTP server
    $mail->Port       = 587;                   // SMTP port
    $mail->Username   = $username;  // username
    $mail->Password   = $password;            // password

    $mail->SetFrom(_POST['email'], _POST['name']);

    $mail->Subject    = "Nouveau message de " . _POST['name'];

    $mail->MsgHTML(_POST['message']);

    $address = "lila.grv@hotmail.fr";
    $mail->AddAddress($address, "Lila");

    if(!$mail->Send()) {
        echo "Mailer Error: " . $mail->ErrorInfo;
    } else {
        echo "Message sent!";
    }

?>
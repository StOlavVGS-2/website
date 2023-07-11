#!/usr/bin/perl -w
#--------------------------------------------------------------------------
# index.pl
#--------------------------------------------------------------------------
use CGI;
print CGI::header();

#binmode(OUT, ":utf8");

print <<HTML;
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Hovedside </title>
</head>
<body>
<center>
HTML

print <<HTML;
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title> - Hovedside - </title>
</head>

<style>
body {
  margin: 0;
}

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 10%;
  background-color: #f1f1f1;
  position: fixed;
  height: 100%;
  overflow: auto;
}

li a {
  display: block;
  color: #000;
  padding: 8px 16px;
  text-decoration: none;
}

li a.active {
  background-color: #04AA6D;
  color: white;
}

li a:hover:not(.active) {
  background-color: #555;
  color: white;
}
</style>

</head>

<ul>

  <li><a class="active" href="index.pl">Hjem</a></li>
  <li><a href="/test/index.pl">Test</a></li>
  <li><a href="/test1/index.pl">Test1</a></li>
  <li><a href="/test2/index.pl">Test2</a></li>
  <li><a href="snake.html">Snake</a></li>

</ul>


HTML



print <<HTML;
<br><br><br><br><br><br><br><br>

<center>
<img src="/Images/welcome.png" alt="switch" width="600" height="400">
</center>


<br><br>



HTML



sub prnhead {
        print "Content-type: text/html\n\n";
}

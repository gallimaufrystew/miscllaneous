

set openssl="C:\openssl-110g\bin\openssl"
set OPENSSL_CONF="..\..\apps\openssl.cnf"

del *.pem *.crt *.srl

@echo off


REM  Root CA: create certificate directly
set CN="Root CA"
%openssl% req -config ca.cnf -x509 -nodes -keyout rk.pem -out r.crt -newkey rsa:2048 -days 3650
	

REM  Intermediate CA 1
set CN="Intermediate CA 1"
%openssl% req -config ca.cnf -nodes -keyout ik_1.pem -out ir_1.pem -newkey rsa:2048
REM  Sign request: CA extensions
%openssl% x509 -req -in ir_1.pem -CA r.crt -CAkey rk.pem -days 3600 -extfile ca.cnf -extensions v3_ca -CAcreateserial -out int_ca1.crt


REM  Intermediate CA 2
set CN="Intermediate CA 2"
%openssl% req -config ca.cnf -nodes -keyout ik_2.pem -out ir_2.pem -newkey rsa:2048
REM  Sign request: CA extensions
%openssl% x509 -req -in ir_2.pem -CA int_ca1.crt -CAkey ik_1.pem -days 3600 -extfile ca.cnf -extensions v3_ca -CAcreateserial -out int_ca2.crt


REM  Server certificate: create request first
set CN="Server Cert"
%openssl% req -config ca.cnf -nodes -keyout sk.pem -out sr.pem -newkey rsa:1024
REM  Sign request: end entity extensions
%openssl% x509 -req -in sr.pem -CA int_ca2.crt -CAkey ik_2.pem -days 3600 -extfile ca.cnf -extensions usr_cert -CAcreateserial -out server.crt


REM  Client certificate: request first
set CN="Client Cert"
%openssl% req -config ca.cnf -nodes -keyout ck.pem -out cr.pem -newkey rsa:1024
REM  Sign using intermediate C
%openssl% x509 -req -in cr.pem -CA int_ca2.crt -CAkey ik_2.pem -days 3600 -extfile ca.cnf -extensions usr_cert -CAcreateserial -out client.crt

if exist output (
  del /Q /F output\*
) else (
  mkdir output
)

move *.crt output
move *.pem output

pause

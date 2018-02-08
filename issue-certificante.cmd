
openssl genrsa -aes256 -out private\\ca.key.pem 4096

openssl req -config openssl.cnf -key private\\ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs\\ca.cert.pem

# verify it
openssl x509 -noout -text -in certs\\ca.cert.pem


openssl genrsa -aes256 -out intermediate\\private\\intermediate.key.pem 4096
openssl req -config intermediate\\openssl.cnf -new -sha256 -key intermediate\\private\\intermediate.key.pem -out intermediate\\csr\\intermediate.csr.pem

# intermediate certificate

openssl ca -config openssl.cnf -days 3650 -notext -md sha256 -in intermediate\\csr\\intermediate.csr.pem -extensions v3_intermediate_ca -out intermediate\\certs\\intermediate.cert.pem
	 
# verify it	 
openssl x509 -noout -text -in intermediate\\certs\\intermediate.cert.pem

openssl genrsa -aes256 -out intermediate\\private\\s.key.pem 2048
	  
openssl req -config intermediate/openssl.cnf -key intermediate\\private\\s.key.pem -new -sha256 -out intermediate\\csr\\s.csr.pem

openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in intermediate\\csr\\s.csr.pem -out intermediate\\certs\\s.cert.pem

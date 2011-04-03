# from http://dpaste.de/61O8/raw/

set -e

echo "Encrypting $2 for $1."

# make a directory to store results for this site
mkdir -p results/$1

# get that site's SSL certificate, validating it with the cacert.pem we have
echo "QUIT" | openssl s_client -CAfile cacert.pem -connect $1:443 > results/$1/cert.pem

# generate a random password from urandom
dd if=/dev/urandom of=results/$1/pass.txt bs=1 count=96

# use the raw password and AES to encrypt the output
openssl enc -a -aes-256-cbc -salt -in $2 -out results/$1/file.enc -pass file:results/$1/pass.txt

# then, use the above public cert to encrypt the pass key
openssl rsautl -encrypt -inkey results/$1/cert.pem -pubin -certin -in results/$1/pass.txt -out results/$1/pass.enc

# finally, delete the password so it's not around and accidentally leaked
rm results/$1/pass.txt

echo "ALL DONE"


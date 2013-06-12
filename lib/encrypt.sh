# Handy symmetric key AES256 file encryption with OpenSSL. Passphrase
# protected.
#
# Examples:
#   $ encrypt myfile.ext
#   <creates myfile.ext.aes256>
#
#   $ decrypt myfile.ext.aes256
#   <creates myfile.ext by decrypting myfile.ext.256>
encrypt () {
    openssl enc -aes256 -in "$1" -out "$1.aes256"
}
decrypt () {
    openssl enc -d -aes256 -in "$1" -out "${1%.aes256}"
}

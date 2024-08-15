# Generate EC parameters for the prime256v1 (secp256v1) curve and save them to ecparam.pem
openssl ecparam -name prime256v1 -out ecparam.pem
# Generate a private key for Party 1 using the prime256v1 curve and save it to party1_private_key.pem
openssl ecparam -name prime256v1 -genkey -noout -out party1_private_key.pem
# Extract and save the public key from Party 1's private key to party1_public_key.pem
openssl ec -in party1_private_key.pem -pubout -out party1_public_key.pem
# Derive a shared secret using Party 1's private key and Party 2's public key, saving the result to shared_secret.bin
openssl pkeyutl -derive -inkey party1_private_key.pem  -peerkey party2_public_key.pem -out shared_secret.bin
# Encrypt body.bin using AES-256-CBC with the shared secret (no salt used) and save the output to body.ecb.bin
openssl enc -aes-256-cbc -nosalt -pass file:./shared_secret.bin -in body.bin -out body.ecb.bin
## Sanctum - Network Encryption Library

OVERVIEW
C library for encrypted network communications using AES-256-GCM and 
ChaCha20-Poly1305. Includes session management, key rotation, replay 
protection, packet fragmentation, and traffic obfuscation.

DEPENDENCIES
- OpenSSL (libssl, libcrypto)
- libsodium
- pthread

COMPILATION
`gcc -o sanctum sanctum.c -lssl -lcrypto -lsodium -lpthread -O2 -Wall`

FEATURES
- Dual cipher support (AES-256-GCM, ChaCha20-Poly1305)
- HKDF key derivation
- Automatic key rotation after 100 packets
- Replay attack prevention with sliding window
- Packet fragmentation for large payloads
- Traffic obfuscation with random padding
- Multi-session management
- Secure memory handling with mlock

USAGE
Initialize library:
```
  crypto_init()
```

Create session manager:
```
  session_manager_t *mgr = session_manager_create(master_secret)
```
Establish session:
```
  crypto_context_t *ctx = establish_session(mgr, peer_id, peer_id_len, 
                                            ephemeral_key, CIPHER_AES_256_GCM)
```

Encrypt data:
```
  encrypt_packet(ctx, plaintext, plaintext_len, &ciphertext, &ciphertext_len)
```

Decrypt data:
```
  decrypt_packet(ctx, ciphertext, ciphertext_len, &plaintext, &plaintext_len)
```

Send large data:
```
  send_fragmented(ctx, data, data_len, &fragments, &frag_lens, &num_fragments)
```

Receive fragments:
```
  receive_fragmented(ctx, fragments, frag_lens, num_fragments, &data, &data_len)
```

Close session:
```
  close_session(mgr, ctx)
```
Cleanup:
```
  session_manager_free(mgr)
```
TESTING
Run built-in test suite:
  `./sanctum`

Tests include encryption/decryption, key rotation, fragmentation, 
replay protection, and cipher modes.

SECURITY FEATURES
- Constant-time comparison for authentication tags
- Secure memory wiping on cleanup
- Memory locking for sensitive data
- Thread-safe operations with mutexes
- Protocol version checking
- Authenticated encryption with additional data (AEAD)

PACKET FORMAT
[version:1][sequence:8][iv:12][ciphertext:N][tag:16]

LIMITATIONS
- Maximum packet size: 65535 bytes
- Replay window: 1024 packets
- Key rotation interval: 100 packets
- Fragment size: 1400 bytes

ERROR CODES;
```
CRYPTO_SUCCESS (0)
CRYPTO_ERR_ALLOC (-1)
CRYPTO_ERR_INVALID_PARAM (-2)
CRYPTO_ERR_ENCRYPT (-3)
CRYPTO_ERR_DECRYPT (-4)
CRYPTO_ERR_AUTH (-5)
CRYPTO_ERR_REPLAY (-6)
CRYPTO_ERR_PROTOCOL (-7)
CRYPTO_ERR_KEY_DERIVE (-8)
CRYPTO_ERR_SESSION (-9)
```

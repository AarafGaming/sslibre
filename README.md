# sslibre

Alternative to OpenSSL, though only has a fraction of its features.

# rand
It produces cryptographically secure random.
It supports numbers
Usage:
sslibre rand *length*

It supports outputting the bytes
Usage:
sslibre rand *length* raw

# hash
It supports SHA256
Usage:
sslibre sha256 "string"

It supports SHA512
Usage:
sslibre sha512 "string"

# encryption
It supports encryption
Usage:
sslibre encrypt "string"

It supports decrypt
Usage:
sslibre decrypt "string"
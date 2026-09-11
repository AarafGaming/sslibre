import std/[sysrand, strutils, os, base64]
import nimcrypto

if paramCount() < 1:
    echo "Not enough arguments"
    quit(1)

if paramStr(1) == "rand":
    if paramCount() < 2:
        echo "Not enough arguments"
        quit(1)

    if paramCount() == 2:
        try:
            var number = ""
            let length = parseInt(paramStr(2))

            for i in 0 ..< length:
                var b: array[1, byte]
                discard urandom(b)

                let digit = int(b[0] mod 10)
                number.add(char(ord('0') + digit))
            echo number
        except:
            echo "Invalid input"
            quit(1)
    else:
        if paramStr(3) == "base64":
            try:
                var number = ""
                let length = parseInt(paramStr(2))

                for i in 0 ..< length:
                    var b: array[1, byte]
                    discard urandom(b)

                    let digit = int(b[0] mod 10)
                    number.add(char(ord('0') + digit))
                echo encode(number)
            except:
                echo "Invalid input"
                quit(1)
        elif paramStr(3) == "raw":
            try:
                let length = parseInt(paramStr(2))
                var buffer = newSeq[byte](length)
                discard urandom(buffer)
                discard stdout.writeBuffer(buffer[0].addr, buffer.len)
            except:
                echo "Invalid input"
                quit(1)
        else:
            echo "Invalid input"
            quit(1)

elif paramStr(1) == "sha256":
    if paramCount() != 2:
        echo "Invalid argument amount"
        quit(1)
    try:
        echo sha256.digest(paramStr(2))
    except:
        echo "Invalid input"
        quit(1)

elif paramStr(1) == "sha512":
    if paramCount() != 2:
        echo "Invalid argument amount"
        quit(1)
    try:
        echo sha512.digest(paramStr(2))
    except:
        echo "Invalid input"
        quit(1)

elif paramStr(1) == "encrypt":
    if paramCount() != 2:
        echo "Invalid argument amount"
        quit(1)
    try:
        let plaintext = paramStr(2)

        var key = newSeq[byte](plaintext.len)
        discard urandom(key)

        var ciphertext = newSeq[byte](plaintext.len)
        for i in 0 ..< plaintext.len:
            ciphertext[i] = byte(plaintext[i]) xor key[i]

        echo "Ciphertext: " & encode(ciphertext)
        echo "Key: " & encode(key)
        echo "Save this key now, it cannot be recovered."
    except:
        echo "Invalid input"
        quit(1)

elif paramStr(1) == "decrypt":
    if paramCount() != 3:
        echo "Invalid argument amount"
        quit(1)
    try:
        let ciphertext = decode(paramStr(2))
        let key = decode(paramStr(3))

        if ciphertext.len != key.len:
            echo "Ciphertext and key must be the same length"
            quit(1)

        var plaintext = newSeq[byte](ciphertext.len)
        for i in 0 ..< ciphertext.len:
            plaintext[i] = byte(ciphertext[i]) xor byte(key[i])

        echo cast[string](plaintext)
    except:
        echo "Invalid input"
        quit(1)
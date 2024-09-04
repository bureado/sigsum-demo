#!/bin/bash

PAYLOAD=/payload.exe
echo "Sending our entry about ${PAYLOAD} to the log..."
time { sigsum-submit -o /proof -p /etc/sigsum/trust_policy -k /sigsum-submit-key ${PAYLOAD} ; }
echo -n "...the hash we inserted is: " ; sha256sum ${PAYLOAD} | cut -d' ' -f1 | base16 -d | sha256sum

echo ""

echo "The public key is:"
cat /sigsum-submit-key.pub

echo ""

echo "The proof is:"
cat /proof

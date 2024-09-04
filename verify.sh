#!/bin/bash

PAYLOAD=/payload.exe
echo "Verifying ${PAYLOAD} proof against trust policy, using submitter's pubkey:"
sigsum-verify -k pubkey -p policy proof < ${PAYLOAD} && echo "Success!"

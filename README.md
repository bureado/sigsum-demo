This repository contains helpful scripts for those looking for a containerized
demonstration of Sigsum.

There are two `Dockerfiles` which build a submitter and a verifier container.

You'll need a payload (a file of any kind) whose checksum will be submitted to
Sigsum's POC log. We'll use the same payload for the verifier. The scripts will
look for a file named `payload.exe`, but the file can be of any kind and type.

Once you have the payload in place, build your container images. This will also
create a throwaway keypair.

Then, run a monitor which is looking for events associated with the public key:

```
docker run --rm -it sigsum-demo:latest sigsum-monitor --interval 10s -p /etc/sigsum/trust_policy /sigsum-submit-key.pub
```

In a different terminal, run a submitter, which will checksum the payload and
submit it, using the private key (a `/submit.sh` script is offered inside the
container for interactive usage):

```
docker run --rm -it sigsum-demo:latest /bin/bash
```

Submission will take a few seconds. You can also look at the monitor for log
entries.

The public key and the proof of inclusion will be displayed at the end of the
`/submit.sh` script. You'll need them in the final step.

Finally, run the verifier. A `/verify.sh` script is included for interactive
usage. We can run this container with `--network none`, because verification
can be done offline, only with the proof.

```
docker run --rm --network none -it sigsum-verifier:latest /bin/bash
```

Copy the pubkey in a file named `pubkey`, and the proof in a file named
`proof`. Run `/verify.sh`

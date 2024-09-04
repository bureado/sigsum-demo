FROM golang:latest

RUN apt update

# Install sigsum
RUN go install sigsum.org/sigsum-go/cmd/sigsum-key@v0.8.0
RUN go install sigsum.org/sigsum-go/cmd/sigsum-submit@v0.8.0
RUN go install sigsum.org/sigsum-go/cmd/sigsum-verify@v0.8.0
RUN go install sigsum.org/sigsum-go/cmd/sigsum-monitor@v0.8.0

# Copy default trust policy
COPY trust_policy /etc/sigsum/trust_policy
COPY submit.sh /submit.sh

# Install a few utilities for the demo
RUN apt install basez -y
RUN apt install nano file strace -y

# Create a keypair
RUN sigsum-key gen -o /sigsum-submit-key

# Show the keypair's hash on every login
RUN echo 'sigsum-key hash -k /sigsum-submit-key.pub' >> /root/.bashrc

# Copy the payload
COPY payload.exe /payload.exe

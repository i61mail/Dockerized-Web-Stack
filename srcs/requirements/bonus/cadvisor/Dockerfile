FROM debian:bookworm

RUN apt-get update && apt-get install -y wget git make gcc 

RUN wget https://go.dev/dl/go1.23.0.linux-amd64.tar.gz

RUN mkdir -p /usr/local/go1.23.0

RUN tar -C /usr/local/go1.23.0 -xzf go1.23.0.linux-amd64.tar.gz

ENV PATH=/usr/local/go1.23.0/go/bin:$PATH

WORKDIR /opt/cadvisor

RUN git clone https://github.com/google/cadvisor.git .

RUN make build

CMD ["./_output/cadvisor"]

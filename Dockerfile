FROM ubuntu:latest

ENV HOME /root
ENV TOOLS_DIRECTORY /tools
ENV NODEDATA_FOLDER /nodedata
ENV PATH $NODEDATA_FOLDER:$TOOLS_DIRECTORY:$HOME:$PATH

ENV PRIV_KEY_FILE $NODEDATA_FOLDER/privkey.json
ENV REPO_NAME AIOZNetwork/aioz-dcdn-cli-node
ENV BINARY_NAME aioznode

## Tools
RUN mkdir $TOOLS_DIRECTORY
COPY tools/*.* $TOOLS_DIRECTORY/
RUN chmod +x $TOOLS_DIRECTORY/*.sh

## Node data
RUN mkdir $NODEDATA_FOLDER
VOLUME ["$NODEDATA_FOLDER"]

## Install deps
RUN dist.update.sh
RUN apt-get install -y $(cat $TOOLS_DIRECTORY/deps.txt)

# Check frequency : Default 1H
ENV CHECK_FREQ 60

# Withdraw options
ENV WITHDRAW_ADDRESS_HEX 0x4D11B64d9bb0652a92FCaD019d7Fc79f14821571
ENV WITHDRAW_MIN_VALUE 10**18

# Entry point
CMD start.sh
# CMD bash
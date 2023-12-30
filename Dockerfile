FROM rinzlerfr/aioznode:latest

# ENV HOME /root
# ENV TOOLS_DIRECTORY /tools
# ENV NODEDATA_FOLDER /nodedata
# ENV PATH $NODEDATA_FOLDER:$TOOLS_DIRECTORY:$HOME:$PATH

# ENV PRIV_KEY_FILE $NODEDATA_FOLDER/privkey.json
# ENV REPO_NAME AIOZNetwork/aioz-dcdn-cli-node
# ENV BINARY_NAME aioznode

# ## Tools
# RUN mkdir $TOOLS_DIRECTORY
COPY tools/*.* $TOOLS_DIRECTORY/
RUN chmod +x $TOOLS_DIRECTORY/*.sh

# ## Node data
# RUN mkdir $NODEDATA_FOLDER
# VOLUME ["$NODEDATA_FOLDER"]

## Install deps
RUN dist.update.sh
RUN apt-get install -y bc

# Check frequency : Default 1H
ENV ENDPOINT http://aioznode:1317
ENV CHECK_FREQ 60

# Withdraw options
ENV WITHDRAW_ADDRESS_HEX 0x4D11B64d9bb0652a92FCaD019d7Fc79f14821571
ENV WITHDRAW_MIN_VALUE 10^18

# Token Infos
ENV TOKEN_NAME aioz
ENV TOKEN_DENOM attoaioz
ENV TOKEN_DECIMALS 10^18

# Entry point
CMD start-watching-reward.sh
# CMD bash
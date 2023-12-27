#args="${@//--env/--build-arg}"
name=$(cat helper.docker.name.txt)
args=""

# Build aioznode image
pushd aioz-node-docker
./helper.docker.clean.sh
./helper.docker.build.sh
popd

echo "docker build $args -t $name ."
docker build $args -t $name .

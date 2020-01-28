arg go_version
from golang:${go_version}-alpine3.11
run apk add --update \
  git openssh-client \
# CGO builds need these:
  gcc musl-dev
env CGO_ENABLED 0

workdir /src

onbuild arg GOPROXY
onbuild arg GONOSUMDB
onbuild add go.mod go.sum ./
onbuild run go mod download

onbuild add . ./
onbuild run go test ./...
onbuild run set -ex; \
    if grep -q '^package main *' *.go; then go install .; fi; \
    if [ -d cmd ]; then go install ./cmd/...; fi

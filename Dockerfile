arg go_version
from golang:${go_version}-alpine3.16
run apk add --update \
  git openssh-client \
# CGO builds need these:
  gcc musl-dev

workdir /src

onbuild arg CGO_ENABLED=0
onbuild arg GOPROXY
onbuild arg GONOSUMDB
onbuild add go.mod go.sum ./
onbuild run go mod download

onbuild add . ./
onbuild run go test ./...
onbuild run set -ex; \
    if grep -q '^package main *' *.go; then go install -trimpath .; fi; \
    if [ -d cmd ]; then go install -trimpath ./cmd/...; fi

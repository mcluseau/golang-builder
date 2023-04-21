arg go_version
from golang:${go_version}-alpine3.17
run apk add --update \
  git openssh-client \
# CGO builds need these:
  gcc musl-dev

workdir /src

onbuild arg CGO_ENABLED=0
onbuild arg GOPROXY
onbuild arg GONOSUMDB
onbuild arg GOPRIVATE
onbuild arg GOINSECURE

onbuild add go.mod go.sum ./
onbuild run --mount=type=ssh go mod download

onbuild add . ./
onbuild run go test ./...
onbuild run go install -trimpath ./...

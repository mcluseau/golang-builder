arg go_version
from golang:${go_version}-alpine3.19
run apk add --update --no-cache \
  git openssh-client \
# CGO builds need these:
  gcc musl-dev

workdir /src

onbuild arg CGO_ENABLED=0
onbuild arg GOPROXY
onbuild arg GONOSUMDB
onbuild arg GOPRIVATE
onbuild arg GOINSECURE
onbuild arg LDFLAGS
onbuild arg EXTRA_PKGS

onbuild run test "$EXTRA_PKGS" = "" || apk add --update --no-cache $EXTRA_PKGS

onbuild copy go.mod go.sum ./
onbuild run \
  --mount=type=ssh \
  --mount=type=cache,id=gomod,target=/go/pkg/mod \
  --mount=type=cache,id=gobuild,target=/root/.cache/go-build \
  go mod download

onbuild copy . ./
onbuild run \
  --mount=type=cache,id=gomod,target=/go/pkg/mod \
  --mount=type=cache,id=gobuild,target=/root/.cache/go-build \
  go test ./... && \
  go install -ldflags "$LDFLAGS" -trimpath ./...


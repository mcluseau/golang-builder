
Sample project `Dockerfile`:

```Dockerfile
from mcluseau/golang-builder:1.21.5 as build

from alpine:3.10
entrypoint ["/bin/myapp"]
copy --from=build /go/bin/* /bin/
```

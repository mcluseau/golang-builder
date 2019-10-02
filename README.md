
Sample project `Dockerfile`:

```Dockerfile
from mcluseau/golang-builder:1.13.1 as build

from alpine:3.10
entrypoint ["/bin/myapp"]
copy --from=build /go/bin/* /bin/
```

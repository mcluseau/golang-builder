
Sample project `Dockerfile`:

```Dockerfile
from mcluseau/golang-builder:1.21.6 as build

from alpine:3.19
entrypoint ["/bin/myapp"]
copy --from=build /go/bin/* /bin/
```

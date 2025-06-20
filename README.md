
Sample project `Dockerfile`:

```Dockerfile
from mcluseau/golang-builder:1.24.4 as build

from alpine:3.22
entrypoint ["/bin/myapp"]
copy --from=build /go/bin/* /bin/
```

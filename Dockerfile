# To correctly make a statically-linked binary, we use Alpine Linux.
# The distro entirely uses musl instead of glibc which is unfriendly to be
# statically linked.
FROM haskell:9.2.5 AS build

LABEL "org.opencontainers.image.title"="Seonbi"
LABEL "org.opencontainers.image.licenses"="LGPL-2.1"

# Add just the package.yaml file to capture dependencies
COPY package.yaml /src/seonbi/package.yaml
COPY stack-ghc-9.2.yaml /src/seonbi/stack.yaml

WORKDIR /src/seonbi

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
# (unless the .cabal file changes!)
RUN stack setup
RUN stack build \
  --only-snapshot \
  --flag seonbi:static

COPY . /src/seonbi
RUN cp /src/seonbi/stack-ghc-9.2.yaml /src/seonbi/stack.yaml

RUN stack build \
  --flag seonbi:static \
  --copy-bins

FROM haskell:9.2.5

COPY --from=build /root/.local/bin/seonbi* /usr/local/bin/
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
CMD ["seonbi"]

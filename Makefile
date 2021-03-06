DOGGO-BIN := doggo

HASH := $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date '+%Y-%m-%d %H:%M:%S')
VERSION := ${HASH}

.PHONY: build
build: ## Build the doggo binary
	mkdir -p bin/; \
	cd cmd/; \
	go build  -ldflags="-X 'main.buildVersion=${VERSION}' -X 'main.buildDate=${BUILD_DATE}'" -o ${DOGGO-BIN} ./... && \
	mv ${DOGGO-BIN} ../bin/${DOGGO-BIN}

.PHONY: run
run: build ## Build and Execute the binary after the build step
	./bin/${DOGGO-BIN}

.PHONY: clean
clean:
	go clean
	- rm -f ./bin/${BIN}

.PHONY: lint
lint:
	golangci-lint run

.PHONY: fresh
fresh: clean build

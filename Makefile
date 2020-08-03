# Default command
.PHONY: default
default: dependencies dev

# Check for dependencies
.PHONY: dependencies
dependencies:
	@command -v fswatch --version >/dev/null 2>&1 || { printf >&2 "fswatch is not installed, please run: brew install fswatch\n"; exit 1; }	

# Run in foreground, stop all services when cancelled
.PHONY: dev
dev: restart
	@fswatch -o cmd/**/* internal/**/* | xargs -n1 -I{} make dev || make stop 2>/dev/null || true

# Run permanently in background
.PHONY: start
start: build
	@./scripts/start.sh

# Build all services
.PHONY: build
build: clean
	@./scripts/build.sh

# Remove all temporary files
.PHONY: clean
clean:
	@./scripts/clean.sh

# Stop and start all processes
.PHONY: restart
restart: stop start

# Run all tests (godotenv cli tool required!)
.PHONY: test
test: 
	godotenv go test ./...

# Run all tests with coverage (godotenv cli tool required!)
.PHONY: test_coverage
test_coverage:
	godotenv go test ./... -covermode=count -coverprofile=./tests/coverage.out fmt && clear && go tool cover -func=./tests/coverage.out	

# Generate test coverage report (godotenv cli tool required!)
.PHONY: test_report
test_report: 
	godotenv go test ./... -covermode=count -coverprofile=./tests/coverage.out fmt && clear && go tool cover -html=./tests/coverage.out
	
# Stop all processes if running in background
.PHONY: stop
stop:
	@./scripts/stop.sh

# Generate Docker images for all go services
.PHONY: docker_build
docker_build:
	@./scripts/docker_build.sh
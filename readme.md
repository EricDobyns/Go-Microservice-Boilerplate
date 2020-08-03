# Go Microservice Boilerplate

This repository contains a general mono-repo microservice boilerplate. This is not an official repository and is meant to provide a basic project structure with some additional build scripts for convenience.

- [x] Support multiple microservices in a single repository
- [x] Support hot-reloading of all microservices on saved changes in a dev environment
- [x] Support generation of docker images for all microservices

<br>

## Getting Started

```
Note: All `make` commands should be run from the project's root directory
```

```
Note: To support hot-reloading install the fswatch dependency via homebrew:
brew install fswatch
```

#### Start all services
This command is meant to have minimal build log output. If a build error occurs run `make build` to debug.
``` bash
make
```

#### Build executables for all services
``` bash
make build
```

#### Run tests
``` bash
make test
```

#### Generate and view test report
``` bash
make test_report
```

#### Remove all temporary files and folders
``` bash
make clean
```

#### Build docker images for all services
``` bash
make docker_build
```

<br>

## Project Structure

This project structure was influenced by the golang-standards layout:<br>
https://github.com/golang-standards/project-layout

### `/bin`

Temporary build directory containing all generated executables.

### `/cmd`

Main applications for this project.

The directory name for each application should match the name of the executable you want to have (e.g., `/cmd/myapp`).

Don't put a lot of code in the application directory. If you think the code can be imported and used in multiple services, then it should live in the `/internal` directory.

### `/database`

Database scripts, schema, migrations, etc.

### `/docs`

Design and user documents (in addition to your godoc generated documentation).

### `/internal`

Private reuseable application and library code.

Note that this layout pattern is enforced by the Go compiler itself. See the Go 1.4 [`release notes`](https://golang.org/doc/go1.4#internalpackages) for more details. Note that you are not limited to the top level `internal` directory. You can have more than one `internal` directory at any level of your project tree.

### `/scripts`

Scripts to perform various build, install, analysis, etc operations.

### `/tests`

Additional external test apps and test data. Feel free to structure the `/test` directory anyway you want.

<br>

## Code of Conduct
Please see the [code of conduct](./.github/code_of_conduct.md) form.

## Contributing
Please see the [contributing](./.github/code_of_conduct.md) form.

## Pull Requests
Please see the [pull request](./.github/code_of_conduct.md) form.

## License
Copyright © 2019-present Eric Dobyns.
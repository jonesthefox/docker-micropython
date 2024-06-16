# Micropython unix port in a Docker container

Run MicroPython in a Docker container for a consistent and portable development environment. This setup is ideal for
testing and running MicroPython scripts on a Unix-like system without needing to install MicroPython directly on your
host machine. It's the fun, yay! ^^

## Build

To build the Docker image, navigate to the directory containing the Dockerfile and run the following command:

```sh
docker build -t micropython-docker .
```

This command will clone the latest MicroPython repository and micropython-lib from GitHub and build the Unix port.

## Run MicroPython

To run MicroPython with a mounted volume for your project, use the following command:

```sh
docker run -it --rm -v /myproject:/volume micropython-docker micropython /volume/main.py
```

Replace `/myproject` with the path to your local project directory and `main.py` with the name of the script you want to
execute.

## Create an alias for Convenience

To simplify the command for running MicroPython, you can create an alias. Add the following line to your `~/.bashrc` (
for bash) or `~/.zshrc` (for zsh) file:

```sh
alias micropython-docker='docker run -it --rm -v /myproject:/volume micropython-docker'
```

After adding the alias, reload your shell configuration:

```sh
source ~/.bashrc  # for bash
source ~/.zshrc   # for zsh
```

Now you can run MicroPython scripts more easily:

```sh
micropython-docker /volume/main.py
```

## Using a Shell Function for Flexibility

For more flexibility, you can define a shell function that allows you to pass different scripts or parameters:

### Bash

Add this function to your ~/.bashrc file:

```sh
micropython-docker() {
    docker run -it --rm -v /path/to/your/project:/volume micropython-docker micropython "$@"
}
```

### Zsh

Add this function to your ~/.zshrc file:

```sh
micropython-docker() {
    docker run -it --rm -v /path/to/your/project:/volume micropython-docker micropython "$@"
}
```

Reload your shell configuration:

```sh
source ~/.bashrc  # for bash
source ~/.zshrc   # for zsh
```

Now you can use the function to run different MicroPython scripts or pass other parameters:

```sh
micropython-docker /volume/main.py
micropython-docker -c "print('Hello from MicroPython')"
```

## Development

When developing MicroPython applications, it's convenient to have your project directory mounted into the container.
This way, you can edit your scripts on your host machine and immediately run them in the container without rebuilding
the image.

Example:

1. Edit your script on your host machine:
   ```sh
   echo "print('Hello from MicroPython in Docker')" > /myproject/main.py
   ```

2. Run the script in the container:
   ```sh
   micropython-docker /volume/main.py
   ```

## Cleaning up

To remove the Docker image when you no longer need it, run:

```sh
docker rmi micropython-docker
```

## References

- [MicroPython Documentation](https://docs.micropython.org/en/latest/)
- [MicroPython GitHub Repository](https://github.com/micropython/micropython)

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

Enjoy running MicroPython in a Docker container! If you encounter any issues or have questions, feel free to open an
issue or submit a pull request.
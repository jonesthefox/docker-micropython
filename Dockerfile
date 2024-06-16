FROM debian:bookworm-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    git \
    pkg-config \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Clone MicroPython repository
RUN git clone https://github.com/micropython/micropython.git

# Clone MicroPython libraries
RUN cd micropython/lib && git clone https://github.com/micropython/micropython-lib.git

# Build mpy-cross
RUN cd micropython/mpy-cross && make

# Build MicroPython for Unix
RUN cd micropython/ports/unix && make submodules && make && make install

# Clean up
RUN apt-get purge --auto-remove -y build-essential libffi-dev git pkg-config python3 && rm -rf micropython

CMD ["micropython"]
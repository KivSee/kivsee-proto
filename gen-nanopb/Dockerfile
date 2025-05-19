FROM python:3.11.10

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y protobuf-compiler libprotobuf-dev && rm -rf /var/lib/apt/lists/*

# Set up Python environment
RUN python -mvenv /app
ADD /requirements.txt requirements.txt
RUN . ./bin/activate \
    && pip install --no-cache-dir -r requirements.txt \
    && pip uninstall --yes pip \
    && rm -f requirements.txt bin/activate.fish bin/activate.csh bin/Activate.ps1

ENTRYPOINT ["protoc", "--proto_path=/proto", "--plugin=/app/bin/protoc-gen-nanopb", "--nanopb_out=/gen", "--nanopb_opt=--options-path=/proto"]

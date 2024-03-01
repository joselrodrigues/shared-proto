# Define the source .proto files
PROTOS := $(wildcard *.proto)

# Define the output .pb.go files for Go
PB_GOS := $(PROTOS:.proto=.pb.go)

# Command for the Protocol Compiler for Go
PROTOC := protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative

# For Python gRPC
PY_PB2 := $(PROTOS:.proto=_pb2.py)
PY_PB2_GRPC := $(PROTOS:.proto=_pb2_grpc.py)

# Command for the Protocol Compiler for Python
PROTOC_PY := python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=.

# Main rule
all: $(PB_GOS) $(PY_PB2) $(PY_PB2_GRPC)

# Rule to generate .pb.go files from .proto files for Go
%.pb.go: %.proto
	$(PROTOC) $<

# Rules to generate Python gRPC files from .proto files
%_pb2.py %_pb2_grpc.py: %.proto
	$(PROTOC_PY) --proto_path=. $<

# Clean rule
clean:
	rm -f $(PB_GOS) $(PY_PB2) $(PY_PB2_GRPC)


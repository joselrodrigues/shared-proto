#Define the source .proto files
PROTOS := $(wildcard *.proto)

#Define the output .pb.go files
PB_GOS := $(PROTOS:.proto=.pb.go)

#Define the command for the Protocol Compiler
PROTOC := protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative

#Main rule
all: $(PB_GOS)

#Rule to generate .pb.go files from .proto files
%.pb.go: %.proto
	$(PROTOC) $<

#Clean rule
clean:
	rm -f $(PB_GOS)

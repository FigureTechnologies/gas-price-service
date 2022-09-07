package main

import (
	"io/ioutil"
	"os"

	"github.com/FigureTechnologies/coin-json-to-proto/coin/github.com/cosmos/cosmos-sdk/types"
	"github.com/gogo/protobuf/jsonpb"
	"github.com/gogo/protobuf/proto"
)

func main() {
	bytes, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		os.Exit(1)
	}
	json := string(bytes)

	coin := types.Coin{}
	err = jsonpb.UnmarshalString(json, &coin)
	if err != nil {
		os.Exit(1)
	}

	bytes, err = proto.Marshal(&coin)
	if err != nil {
		os.Exit(1)
	}

	os.Stdout.Write(bytes)
}

package main

import (
	"tool/cli"
	"tool/file"
	"encoding/yaml"
)

let environments = [
	"uat",
	"preprod",
	"prod",
]

#NS: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: string
}

command: {
	hello: {
		cli.Print & {text: "Hello, Cue"}
	}

	hellotxt: {
		for env in environments {
			"ns-\(env)": file.Create & {
				filename: "\(env).yaml"
				contents: yaml.Marshal(
						#NS & {metadata: name: env},
						)
			}
		}
	}
}

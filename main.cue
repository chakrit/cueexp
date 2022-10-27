package main

import (
	"encoding/base64"
)

//
// Escape YAML hell with CUE
//
// See:
//  * https://cuelang.org/
//  * https://cuelang.org/docs/about/
//  * https://pkg.go.dev/cuelang.org/go/cue
//
// Abstraction & Computation in data, quickly and safely.
//
// TOC:
//   1. YAML Hell
//   2. History of CUE
//
//        ...
//
//  10. cue_tool
//  11. Demo
//

//   3. Hello World
alpha: {
	hello: "World"
	// cue export --out json -e alpha
	// cue export --out yaml -e alpha
}

//   4. 1st class types
beta: {
	hello: string
	hello: "World"
}

gamma: {
	hello: int | string
	hello: "World"
}

//   5. Combining constraints
delta: {
	num: int & >=0
	num: 4
}

epsilon: {
	#User: {
		username: string
		password: string
	}

	users: [...#User]
	users: [
		{username: "chakrit", password: "123456"},
	]
}

zeta: {
	min: int & <max
	max: int & >min

	min: 1
	max: 10
}

//   6. Variables & Path References
eta: {
	let ns = "cueapp"

	namespace: {
		metadata: {
			name: ns
		}
	}

	ingress: {
		metadata: {
			name: ns
		}
	}
}

theta: {
	#App: {
		ns: string

		namespace: {
			metadata: {
				name: ns
			}
		}

		ingress: {
			metadata: {
				name: ns
			}
		}
	}

	#App & {ns: "cueapp"}
}

//   7. "Classes"
iota: {
	#UserV1: {
		id:       int
		username: string
	}

	#UserV2: {
		#UserV1
		role: string
	}
}

//   8. Comprehensions
kappa: {
	#User: {
		id:       int
		username: string
	}

	usernames: [
		"chakrit",
		"gatuk",
		"pan",
		"jakkrij",
	]

	users: [...#User]
	users: [
		for index, name in usernames {
			id:       index
			username: name
		},
	]
}

lambda: {
	#UserV2: {
		kappa.#User
		role: string | *"guest"
	}

	usersv2: [...#UserV2]
	usersv2: [
		for user in kappa.users {
			id:       user.id
			username: user.username
		},
	]
}

//   9. Supporting functions
mu: {
	secret: {
		DATABASE_URL: "postgres://user:pass@server"
		SECRET_KEY:   "e9aaaf1de912fbbc64273e997"
	}

	secret64: {
		for key, value in secret {
			"\(key)": base64.Encode(null, value)
		}
	}
}

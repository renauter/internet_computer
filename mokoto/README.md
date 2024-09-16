# MOTOKO

## Useful links

- The Motoko Programming Language Book [link](https://motoko-book.dev/index.html)

## Getting Started with Motoko

### Internet Computer Software Development Kit (IC SDK)

Software Development Kit for creating and managing canister smart contracts on the ICP blockchain.
https://github.com/dfinity/sdk

### Install the IC SDK on macOS/Linux

https://internetcomputer.org/docs/current/developer-docs/getting-started/install/#installing-dfx-via-dfxvm

~~~sh
sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
~~~

### About `dfx` command-line tool

`DFINITY` command-line execution environment:
https://internetcomputer.org/docs/current/developer-docs/developer-tools/cli-tools/cli-reference/dfx-parent

### Create a new project

Once the SDK is installed, you can create a new project using the dfx command-line tool:

~~~sh
dfx new <my_motoko_project>
cd <my_motoko_project>
~~~

Project structure:
https://motoko-book.dev/project-deployment/local-deployment.html#dfx-project-from-scratch

- `src/<my_motoko_project>/main.mo`: This is your main Motoko source file.
- `dfx.json`: This file contains your project configuration (list of canisters)

### Write your Motoko code

Open `src/<my_motoko_project>/main.mo` and start writing your Motoko code.

### Build and deploy

Use the following commands to build and deploy your project locally:

Start the local Internet Computer replica as a background process (deamon)

~~~sh
dfx start --background
~~~

Stop the background process:

~~~sh
(use `dfx stop` )
~~~

Check the status of the background replica:

~~~sh
dfx ping
dfx info
~~~

Register, build, and deploy a dapp on the local canister execution environment:

~~~sh
dfx deploy
~~~

Which is equivalent (considering all canisters of your project) to :

~~~sh
dfx canister create --all
dfx build
dfx canister install --all
~~~

Detailling each step for a specific canister:

1. [Create empty canister](https://motoko-book.dev/project-deployment/local-deployment.html#create-empty-canister)

~~~sh
dfx canister create <my_cansiter_name>
~~~

2. [Compile Motoko code into a wasm file](https://motoko-book.dev/project-deployment/local-deployment.html#build-motoko-code)

~~~sh
dfx build <my_cansiter_name>
~~~

3. [Installing the wasm in the canister](https://motoko-book.dev/project-deployment/local-deployment.html#installing-the-wasm-in-the-canister)

~~~sh
dfx canister install <my_cansiter_name>
~~~

Get status of canister once deployed:

~~~sh
dfx canister status <my_cansiter_name>
~~~

### Mops (Motoko Package Manager)

- Install Mops:

~~~sh
npm install -g ic-mops
~~~

- Initialize Mops in your project:

~~~sh
mops init
~~~

- Add CanDB to your project:

~~~sh
mops add candb
~~~

## Examples

### Counter

~~~motoko
actor Counter {
    var counter : Nat = 0;

    public func setCounter(newCounter : Nat) : async () {
        counter := newCounter; // We assign a new value to the counter variable based on the provided argument 
        return;
    };

    public func incrementCounter() : async () {
        counter += 1; // We increment the counter by one
        return; 
    };
    
    public query func getCounter() : async Nat {
        return counter;
    };
}
~~~

- Build and deploy your project

- Interact with your canister:

~~~sh
dfx canister call counter getCounter
dfx canister call counter setCounter '(3)'
dfx canister call counter incrementCounter
~~~

### Using CanDB for a Simple Database

This example demonstrates how to:
    - add a user to the database
    - retrieve a user from the database

- Update your `main.mo` file with the following code:

~~~motoko
import CanDB = "mo:candb/CanDB";
import Entity = "mo:candb/Entity";

actor {
    // Initialize the CanDB instance
    private let db = CanDB.init();

    // Define a function to add a user
    public func addUser(name: Text, age: Nat) : async Text {
        let user = {
            name = name;
            age = age;
        };
        
        let entityId = await db.put("user", user);
        "User added with ID: " # entityId
    }

    // Define a function to get a user
    public query func getUser(id: Text) : async ?{name: Text; age: Nat} {
        let result = await db.get("user", id);
        switch (result) {
            case (null) { null };
            case (?entity) {
                switch (entity.data) {
                    case (#User(user)) { ?user };
                    case (_) { null };
                }
            };
        }
    }
}
~~~

- Update your `dfx.json` file to include the CanDB package:

~~~json
{
  "canisters": {
    "my_motoko_project": {
      "main": "src/my_motoko_project/main.mo",
      "type": "motoko"
    }
  },
  "defaults": {
    "build": {
      "packtool": "mops"
    }
  }
}
~~~

- Build and deploy your project

- Interact with your canister
You can now use `dfx canister call` to interact with your canister. For example:

~~~sh
dfx canister call my_motoko_project addUser '("John Doe", 30)'
dfx canister call my_motoko_project getUser '("generated-id-here")'
~~~

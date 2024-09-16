# INTERNET COMPUTER

## Overview of ICP blockchain

https://internetcomputer.org/docs/current/developer-docs/getting-started/overview-of-icp

## Explorers

IC Dashboard: https://dashboard.internetcomputer.org/
Provides an overview of the network's status, including subnet information, block height, and transaction metrics.

Blockchain explorer: https://www.icpexplorer.org/#/
Provides information about transactions, accounts, and canisters.

## Cycles

https://internetcomputer.org/docs/current/developer-docs/getting-started/cycles/cycles-faucet

## Development workflow

This workflow outlines the process from writing smart contracts to deploying and interacting with them on the Internet Computer, highlighting the key tools, environments, and methods used throughout the development lifecycle.

1. Smart Contract Development:
    - Smart contracts are written in high-level languages (JavaScript/TypeScript, Motoko, Python, or Rust)
    - Code is compiled into WebAssembly (Wasm) for execution on the IC

2. 1Key Development Tool:
    - `dfx`: A command-line tool for the entire development process
    - Handles project setup, compilation, deployment, and management

3. Project Structure:
    - Typically includes frontend and backend canisters
    - Frontend: Web assets (JS, HTML, CSS, images)
    - Backend: Core program logic

4. Candid:
    - IC's Application Binary Interface (ABI) language
    - Ensures interoperability between smart contracts written in different languages

5. System API and CDKs:
    - System API: Low-level functions for Wasm interaction
    - Canister Development Kits (CDKs): High-level wrappers for the System API

6. Development Environments:
    - `dfx` (macOS and Linux)
    - Windows Subsystem for Linux (WSL)
    - Cloud-based: Gitpod, GitHub Codespaces
    - Containers (e.g., Docker)
    - Juno (blockchain-as-a-service platform)
    - Playground (temporary sandbox environment)

7. Deployment Options:
    - Local testnet (using dfx start)
    - Mainnet (requires ICP tokens or cycles)
    - Deploy command: `dfx deploy`

8. Interacting with Smart Contracts:
    - Browser-based UI interaction
    - `dfx canister call` command
    - Off-chain programs using agent libraries
